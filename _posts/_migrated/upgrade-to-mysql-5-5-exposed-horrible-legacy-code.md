# [Upgrade to MySQL 5.5 exposed horrible legacy code](./upgrade-to-mysql-5-5-exposed-horrible-legacy-code)
- 2012/02/02
- Technology

One of the applications we support at work is a tangled web of legacy code.  (Aren't they all?)  It's called Simplemerce and it's made by [Avetti](http://www.avetticommerce.com).  It's been around since before I started at my current job, so we're talking at least 5 years old now.  I'm not saying its Avetti that's to blame because I think there were outside contractors that came in and "customized" it to "fit" our needs.  But it's a fucking train wreck of a code base.  Not only are their build-time properties, but those build time properties point to XML properties that contain nearly identical information - some of which is the database connection.  If they don't match up exactly, the application fails to start.

On Wednesday, our DBAs (specifically our new MySQL DBA who started a week prior) upgraded our lone (don't get me started) MySQL server that, among other things, backed Simplemerce, a number of our webservices, and the main database for the customer-facing websites from version 5.1 to 5.5.  Now if we were a good little software shop that adhered to the industry best practices, we would have caught this.  Each team that had an application that used the MySQL server would have run its integration tests and signed off on the upgrade before it made it to production.  But woe-is-us, we aren't.  I do think we took the time to "smoke" test our applications - that is, QA clicked around for a few hours and didn't notice any glaring errors.

To fully understand this amazing architecture and where we screwed up, I need to sidebar for a minute to explain how the Simplemerce is designed: there are essentially 4 applications living in this one application code base.  The first part is the customer facing ecommerce store.  Its nothing to write home about.  It doesn't even really take payments - just orders.  The second part is the management interface that controls the items available in the customer facing portion of the website.  The third part is the EXACT SAME MANAGEMENT INTERFACE where you control the items available in the costumer facing portion of the website.  I didn't copy and paste that twice.  How it works is you stage - create and view and edit until they're ready for public consumption - your items, then you publish them from one management interface to the other.  My jaw is open in amazement right now as I'm typing this because it shocks me every time.  The fourth part of the application is the management interface for customer orders that customer service uses when customers call in to either place an order or edit an existing one, despite being able to do both online (our customers are sometimes really old and don't understand newfangled computers).  The fifth part is the management interface that our in store workers access to print the days orders.  This should have been 4 completely separate applications - Part 1, Parts 2 and 3, Part 4 and Part 5 - that all shared a common data access and/or service layers.  But it's one nasty, large, intertwined application.

Back on track: it should come as no surprise that in our "smoke" test, we missed part 4.  Hell, let's be honest, I'm pretty confident we didn't really check parts 2-5.  Merely, opened the application and made sure there were no errors.  At this point, you should be hearing a little siren going off in the distance.

So let me give Avetti and the contractors some credit - they tried their darndest to have a tiered code structure.  There were DAOs, BAs, servlets and controllers (yes, mixed together - sirens getting louder), and they even tried to use Hibernate.  Unfortunately, there's about 30 classes to a package, all the jsp files are in the root of the application directory, and although they configured Hibernate for really basic use cases, they butchered the DAO layer with inline hard coded SQL statements:


	/**
	 * Collect the order items that belong to the order specified by the 
	 * orderid.
	 * 
	 * @param orderID the id of the order for which to collect OrderItems.
	 * @return a <code>List</code>
	 */
	public List getOrderItemsByOrderedId(int orderID) {
	    List retVal = new Vector();
	    
	    StringBuffer buf = new StringBuffer("select oi.*, oia.*, i.weighteditem, ").
	        append("ia.position, p.* as deptValue from (orderitems as oi, ").
	        append("properties as p, items as i) left join orderitemattribs as oia on ").
	        append("(oi.orderid=oia.orderid and oi.orderitemid=oia.orderitemid)").
	        append(" left join itemattrib ia on (oia.attributeid=ia.attributeid").
	        append(" and oi.vendorid=i.vendorid and oi.code=i.code and i.itemid=ia.itemid) where ").
	        append("oi.orderid=").append(orderID).append(" and oi.vendorid=i.vendorid and oi.code=i.code and i.itemid=p.itemid ").
	        append("order by oi.orderitemid, ia.position;"); 
	        
	    ResultSet rs;
	    //int result=0;

	    HDbBean db = new HDbBean();
	    try {
	        db.connect();

	        rs = db.execSQLQueryUsingJDBC(buf.toString());

	        if(rs != null) {
	            int orderitemid = Integer.MIN_VALUE;
	            int propertyid = Integer.MIN_VALUE;
	            long attributeid = Long.MIN_VALUE;
	            String pszVendorId = "";

	            OrderItem oi = null;
	            Vector attList = null;
	            ArrayList propList = null;
	            
	            while(rs.next()) {
	                
	                if (rs.getInt("orderitemid") != orderitemid) {
							
	                    orderitemid = rs.getInt("orderitemid");
	                    pszVendorId = rs.getString("vendorid");
	                    oi = OrderItemsDAO.readData(new OrderItem(), rs);
	                    oi.setWeightedItem( rs.getInt("weighteditem") );
	                
	                    attList = new Vector();
	                    propList = new ArrayList();
	                    oi.setAttributes(attList);
	                    oi.setProperties(propList);
	                
	                    retVal.add(oi);
	                }

	                if (attributeid != rs.getLong("id")) {

	                    attributeid = rs.getLong("id");
	                    AttributeBean bean = OrderItemAttributeDAO.readData(
	                        new AttributeBean(), rs);
	                    
	                    attList.add(bean);
	                }

	                if (propertyid != rs.getInt("propid")) { 
	                    
	                    propertyid = rs.getInt("propid");
	                    
	                    propList.add(PropertyDAO.readData(pszVendorId,
	                        orderitemid, rs));
	                }
	            }
	        
	            rs.close();
	        }	
	    } catch (SQLException ex) {
	        logger.warn("Error querying for order items.", ex);
	        
	    } catch (ClassNotFoundException ex) { 
	        logger.warn("Error querying for order items.", ex);
	        
	    } finally {
	        try {
	            db.close();
	        } catch (SQLException ex) {
	            logger.warn("Error closing db.", ex);
	        }
	    }
	    return retVal;
	}

Oh, Hey!  Look!  They javadoc'd their code!  Also, I fixed all the white space.  This was unreadable before that.  The first thing I do after installing Eclipse, my IDE of choice, is turn on "Show all whitespace characters".  You can tell how good code is by how consistent the use of whitespace characters is.  

Did I mention they'd already configured Hibernate?  But the extent to which they'd done it was to select objects by id.  Look at that awesome StringBuffer constructed SQL statement!  No, I mean really look at it.  Do you see what's wrong?

	p.* as defaultValue

They're trying to alias every column in a table with the same alias!  WTF!?!?!  How could this ever work?  Well, it turns out MySQL 5.1 would ignore aliasing if its faulty.  Unfortunately for us, MySQL 5.5 doesn't.  It threw a SQLException when executing the query.  What would happen to that exception?  It was caught.  It was logged.  It was...SWALLOWED!!!!!  WHAT??!?!

So let's summarize: we upgraded an underlying database server without running integration tests and failing to verify that it didn't impact our applications partly because we suck at thorough testing but also because this terrible, terrible code swallows errors rather than properly raising exceptions.

We're currently working on a new project that is slated to replace this.  But it can't come soon enough.  We've always made an effort to properly structure our code into appropriate tiers and well documenting code we write or change.  We try to use libraries such as Atomikos, Hibernate, EHCache (among others) to make our lives easier and our code cleaner and more organized.  But with this project in particular, we've focused on improving our error handling.  Not that we were ever this bad, but we could still use some improvement.  

Seeing the code in this application sincerely motivates me.  I certainly don't want to leave behind something that is unmaintainable as Avetti and the contractors have done.  But most importantly, I don't want to be embarrassed by anything I leave behind.  And this is about as embarrassing as it can be.  But hey, they javadoc'd.