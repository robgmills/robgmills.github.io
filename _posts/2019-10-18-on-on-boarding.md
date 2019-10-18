---
layout: post
title: "On on-boarding"
date: 2019-10-18
categories: management
---

"On-boarding" is defined as the actions required of an organization and newly-hired individual to get that individual to contribute to their potential.  When evaluating the ability of an organization to on-boarding an individual, there are two key metrics to focus on: _time to first contribution_ and _personal velocity_.

## Time to first contribution

_Time to first contribution_ is the measurement from an individual's start date until a change they have made to code is deployed to production. In general, the shorter this time period is, the better. 

Tracking this measurement helps shake out issues with:

* organizational structures (e.g dependencies and communication channels)
* documentation (how to contribute to the code, how to deploy); and 
* processes  (overkill gates, manual steps)

This measurement must be taken from the individual's start date. Waiting until corporate on-boarding is complete introduces opportunity to fudge the numbers.

[Companies such as Etsy require their engineers to deploy and revert a fix on their first day.][etsy-day-one-deploy] This instills in their new hires an expectation of deploying often without fear and enables their team to move quickly when introducing new value and recovering from mistakes.

The measurement can be influenced by the complexity of the individual's first task. Adding a large functional change to a core feature is risky and therefore should be treated with more care which, in turn, slows down the overall software development lifecycle. Since the intent of this measurement is to evaluate and introduce the individual to everything required to make a change, I regularly encourage my new hires to make an inconsequential change such as introducing a new log statement, adding a test, or even making an empty commit and going through the change management process.

This measurement shouldn't just be captured for new hires. Lead time to production is an important metric for a company's agility (and therefore ability to outpace the competition).

## Personal velocity
_Personal velocity_ captures the level at which an individual can contribute value and their growth.  In general, this should increase rapidly at the start of an individual's tenure as they ramp up on an organization.  Once an individual has established a baseline velocity, it can be used to measure growth over time as the individual starts to own and complete increasingly complex tasks and/or more simple tasks.  

[This metric is also easily "gamed."][goodharts-law]  Since we rely our our team members to evaluate the complexity of an issue, and individual can artificially inflate the complexity of a task, pushing up their velocity.  This natural human tendency can be offset by calculating personal velocity over task count over time.  This encourages folks to work on more complex tasks or to "kill two birds with one stone" (solve for multiple problems with one task).

## Other on-boarding focuses
It is common for companies to focus on things like "improving on-boarding documentation" or a subjective self-assessment of the on-boarding process (usually performed by new hires).  These are both very valuable things to have at your company, but will likely be addressed by tracking and improving the measurements above.  Therefore, they should not be the primary focus of your organization.

### On-boarding documentation
What is "good" on-boarding documentation?  Good documentation is hard to measure and, more importantly, difficult to maintain.  The point of "good documentation" is to reduce the time to first contribution which is more easily measurable.  

If the focus is "good documentation," keep the documentation to a minimum:

* Include a one line terminal command to test and compile the code and execute it locally on the laptop
* Include a CODEOWNERs file to make it clear who should review changes to the code
* Include description for developers outside of the team to contribute to the code
* Include references (links) to build and deployment jobs, dashboards visualizations for application metrics, and where to find running deployments
* Include sequence diagrams describing all inter-system interactions as UML in the code (to make it easier to keep up-to-date with the representative changes)

### Self-assessments
Similarly, people use self-reported assessments to evaluate their organization's on-boarding process.  But there are a number of issues with reviews that this use-case is particularly susceptible to:

* [Small sample size and high variability leads to low statistical value][amazon-review-data] and increases likelihood of interpretation bias or allows a few reviews to skew the results
* [Reviews are generally left by people that either "brag" or "moan" about the subject, leading to two modes of distribution in the results][two-mode-reviews] and ignores a large but valuable silent contingent
* [Reviewers have different interpretations of what "good" means][xkcd-937] leading to reviews that are not relevant to the core objective

Some larger companies in which on-boarding happens much more frequently might be able to compile a large enough sample size for these reviews to be statistically valuable.  But even then, you must make a decision to either create a restrictive survey to keep responses focused which introduces surveyor bias at the start of the process and might miss out on valuable information not being tested for, or you leave the review open which becomes hard to reliably measure.

[goodharts-law]: https://en.wikipedia.org/wiki/Goodhart%27s_law
[etsy-day-one-deploy]: https://codeascraft.com/2012/03/13/making-it-virtually-easy-to-deploy-on-day-one/ 
[amazon-review-data]: http://jmcauley.ucsd.edu/data/amazon/ 
[two-mode-reviews]: https://dl.acm.org/citation.cfm?doid=1134707.1134743
[xkcd-937]: https://xkcd.com/937/ 
