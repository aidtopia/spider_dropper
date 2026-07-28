# Stupidly Simply Spider Dropper

by Adrian McCarthy

A mechanism to "drop" a spider (or other lightweight prop) for Halloween fun.

## Overview

There are several versions of spider droppers out there.  Most require a microcontroller (like an Arduino Uno) and two actuators (for example, a motor to spool up the spider and a servo or solenoid to initiate the drop).  There are single-motor versions, but they require a reversing motor (which doesn't "drop" the spider so much as lower it) and a motor controller.

There's also at least one commercial "dropping spider" available at Halloween stores and party stores.  Those put the mechanism in the body of a comically unrealistic spider.

Although I enjoy programming and more complex projects, I wanted to make a spider dropper that required fewer parts (a.k.a. cheaper) and would be accessible to haunters who aren't interested in electronics, microcontrollers, and programming.

So I came up with the Stupidly Simple Spider Dropper.

("Stupidly Simple" refers to the design of the mechanism, not the haunters who use them.  The name is inspired by the KISS principle:  Keep It Simple, Stupid.)

There are three configurations:

1. Stupidly Simple Spider Dropper AC
2. Stupidly Simple Spider Dropper DC
3. Stupidly Simple Spider Dropper DC with the Slightly Smarter upgrade.

In the `docs` subfolder, you'll find the [Assembly Instructions](docs/assembly.md) as well as the [User Guide](docs/user_guide.md).

The `notes` subfolder is a hodgepodge of design ideas and information.

The `parts` subfolder has the OpenSCAD files that generate the 3D-printable parts (and some tools to help assemble them).  It also has a spreadsheet of what parts are needed, as well as links to specific items that I've used and some approximate pricing information.

The `schematics` subfolder has the KiCad files for the Slightly Smarter circuit.

## History

I'm a member of the Northern California Haunters Group.  We meet up several times a year to build Halloween props.  During a brainstorming session for the following year's Make & Take calendar, a fellow haunter suggested spider droppers.

There are several such projects online, but I think her suggestion may have been inspired specifically by [Arduino Dropping Spider Halloween Widget 62](https://www.youtube.com/watch?v=s5qQ0CaRchc) on the NYC CNC YouTube channel.  It's a neat project that has a mechanism using two servo motors (requiring modifications to one of them), an Arduino, and a ultrasonic distance sensor.  The immediate reaction from others in the group was that it was too ambitious to make in a few hours on a Saturday.  And that was probably true.

But it got me wondering whether there might a simpler way to achieve the same effect.  What if I could devise a 3D-printable mechanism that required only one motor to drive the drop and the reset?  Could it be done without a microcontroller?  Would a continuous drop-and-reset cycle provide creepy ambiance?

I had some "reindeer" motors left over from a previous project.  These are synchronous motors geared down to 6 RPM in a weather-resistant housing.  They're very light duty, but a toy spider isn't very heavy.  If I could base the cycle around one revolution of the motor, that would repeat every 10 seconds, which felt like a good pace.  My hope was that the dropper would be simple and inexpensive enough that a haunter could deploy a few of them in a spider-infested haunt to create creepy ambient motion.

The trick was to figure out how to have two different phases:  dropping and winding.  After trying to think up cam-driven mechanisms, I came up with the key idea that's powered this project:  A drive gear with a toothless section that allows the spool to spin freely.

I 3D-printed multiple prototypes trying to implement the idea.  The basic idea worked, but the spider bounced and spun around too much.  And the mechanism was prone to jamming when the bounce created enough slack to cause the string to get tangled in the mechanism.

I thought the solution was going to be to use elastic string to dampen the bounce from the sudden stop at the bottom of the drop.  I gave out a couple prototypes to fellow haunters to beta test in their displays.  The elastic string had made things worse.  The bounces were even more chaotic, and the spider's legs would get tangled in the string.  When it was hoisted back up, the spider would reach the top too soon and lock up the mechanism.  One of my beta testers painstakingly attached thread to the tips of each spider leg to keep the elastic string from getting between the legs.

On and off over the next couple years, I iterated on the design.  Elastic string was out.  Regular string (like kite string) was also problematic: The tension in the braid makes the spider want to spin like an ice skater, and, over time, it gets stretched out.  A big breakthrough was using monofilament (fishing line).  With a better spool design, monofilament is much less prone to tangling.

I switched to an open framework base plate because I thought it would look cool and be easier to experiment.  The unexpected benefit was that the open base plate doesn't amplify the motor noise.  The original slab design resonated with the motor vibrations, making it significantly louder.

I added skate bearings to the spool to reduce friction and avoid wear of the plastic parts.  This too had an unexpected (and more important) effect:  The additional rotational inertia of the bearings causes the spider to drop more smoothly, which looked better and further reduced problematic bouncing.

At some point, another Norcal haunter mentioned that he would be more interested in a DC version than one that uses an AC reindeer motor.  I searched around and found the JGY-370 motors, which are available with gear reduction to 6 RPM, just like the reindeer motors.  I made the base plate accommodate both styles of motor mount, but that still required two versions of the gears and spools due to differences in the shaft height and diameter.  I factored out those differences by creating the shaft adapaters which allow the rest of the mechanism to be motor-agnostic.

Despite all the progress, I grew bored with the project.  The continuous operation just wasn't as interesting as a drop triggered by the presence of the victim.

Around this time, I was playing around with mini PIR motion sensors.  PIR motion sensors generally aren't the right solution for triggering a startle effect because they're sensitive over a large area.  Haunters often try to control the field of view by recessing the sensors in a bit of PVC pipe, which helps but can be bulky.  And older sensors generally require a microcontroller to deal with "settling time" and "debouncing."  But these newer PIR sensors have a built-in microcontroller that handles those details.  These were small enough to fit into a discreet 3D-printed housing to control the detection zone.  In fact, I'd already designed such a housing.  I had even figured out how to reduce false triggers from distant motion.  They could be powered with 12 volts, the same voltage as the DC motors.  And they were inexpensive.

With what I'd learned about these newer PIR motion sensor, I realized I could start the DC motor turning with a simple circuit.  The only trick would be to turn the motor off just before the spider was about to drop.  I was vaguely aware of the "park" feature in windshield wiper motors, so I studied how those worked.  That was the last puzzle piece in the design of the Slightly Smarter upgrade.

I managed

And that inspired me to further refine the design until I had a kit design I felt good enough to share with other.

## Thanks To

Lynn for proposing a spider dropper Make & Take all those years ago.

CNC NYC for their inspiring spider dropper project.

Rex for teaching me enough about electronics to be dangerous, for opening my eyes to 3D printing and OpenSCAD, and for coming along on the journey from learning KiCad to making a custom PCB.

Ralph, Gigi, Mike, and Phyllis for beta testing and feedback.  Ralph and Gigi also helped me keep my mind open to mechanical solutions.  Mike for inspiring deeper exploration of sensors for triggering props.

DJ and Ernie who stress tested the first Slightly Smarter Spider Dropper in a real-life haunt during Halloween.

Mendora, Britta, and Glen for showing me that there is enough demand for the Stupidly Simple Spider Dropper to keep me motivated.

Jeff for helping out our fellow haunters with their soldering skills.

Suzanne for always reminding me that the techie projects need the crafty bits, too.

Kristi and Scott for hosting the (first?) Norcal Haunters Spider Dropper Make & Take.
