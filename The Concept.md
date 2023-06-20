# The Concept

## The Three Questions

Before we dive right into coding, we should first answer three questions, that determine and guide our entire design and implementation.

+ What Information do we need to get started?
+ What Steps do we need to take?
+ What is our outcome?

The usual process is address them in reverse!

> What is our outcome?

Life is a text exercise, and in communications there are a lot of assumptions from both side.
When starting a task, be sure to as explicitly as possible clarify just what the desired outcome is.
For example, if you are asked to "generate a report of XYZ" that leaves a lot of questions open:
What format, what information, WHY this is needed, ...
The less we guess about that, the better our results.

> What Steps do we need to take?

The common engineer issue is that we like to immediately dive into solving the tech issues.
We are quick to answer the "how?", neglecting to first start with "what?".
This stop is all about the "what?" - see the example files as we filled them out during the session.

> What Information do we need to get started?

This is the input the script absolutely needs (and become our parameters).
When you plan for this, consider what information your script can gather itself - we are automators!

> No Plan survives the first Enemy Contact

This plan is NOT set in stone - it is perfectly fine to later realize you need to modify it!
The key benefit is to give our script a clear structure and break problems down into digestible steps, not to have a perfect project plan all nailed down.

## How to reach the steps

Now it's ... nice that we ask ourselves "What Steps do we need to take?", but ... _how_ do we figure those out?
Well, experience and understanding of the technologies and products involved in the problem really, really help.

But what if we are still struggling?
Or are facing something new?

Well, for that we have two proposed processes:

> Do it Manually in the UI, then translate

This is mostly a viable solution for simpler problems, alas.

On the plus side, this usually leads to easily grasped code, but in return the resulting code is usually inefficient and makes no use of many features PowerShell as language or the modules offer.

> The Four Phases of Processing: TDER

A more abstract approach that has proven quite reliable and still understandable:

+ Target: Determine Targets to Process
+ Determine: For each target, gather the information needed to execute the intended outcome
+ Execute: Use the data determined to reach the outcome
+ Report: Report on your execution (often optional)

## The Implementation

Finally you get to code!
But ... how do we set that up?

Well, check out the reference script in this repository, but basically we split the script into sections:

+ Documentation
+ Parameters
+ Global Error Handling
+ Configuration
+ Functions
+ Main

> Documentation

Undocumented code is a crime against your future self.
Don't make your future self hat you.

Also use Comment Based Help format so PowerShell understands it as well.
Synopsis, Description, each parameter and at least one example with description.

Keep in mind, it's going to haunt you if you don't.

> Parameters

Default parameter block, try to select proper types and include validation where possible.

> Global Error Handling

To ensure no matter what goes wrong, your script ends gracefully.
Ensure the logging is in order and the system running your script realizes it failed

```powershell
$ErrorActionPreference = 'Stop'
trap {
    Write-Warning "Script Failed: $_"
    throw $_
}
```

> Configuration

Load up any configuration information / runtime settings here.
Do _not_ use this for business logic!
It's totally fine to leave this empty / remove this section if not needed.

If you need global config settings, use script-scope, not global-scope.
Always include a scope prefix, even for reads and ideally have dedicated commands for accessing those values, rather than having all functions access them directly.

> Functions

This is where your actual implementation of the script happens.
Add however many functions you believe are needed.
Keep function best practices in mind, such as all information needed through parameters, all results through output.
Also add help where viable, it helps.

This section is where a large portion of this processes growth scaling comes from - if you adhere to function best practices, it becomes easy to harvest commands for other scripts or move them into dedicated modules.

> Main

The main section of the script exists only to show the primary business logic.
_Everything_ else should be in the functions.
Don't use comments, don't use Write-Host or similar commands.
If the names and variables used here do not speak for themselves, fix the naming, don't add more fluff.

As a rule-of-thumb, if you need more than 15 lines of code here, you probably want to wrap some of the steps into another function representing the sum of those steps.
By keeping this section as simple as possible, you can come back a year later and figure out what even a complex script does in minutes.

Also great for script-callstacks in errors...
