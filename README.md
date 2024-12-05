# Stupidly Simply Spider Dropper

by Adrian McCarthy

A mechanism to "drop" a spider (or other lightweight prop) for Halloween fun.

## Overview

There are several versions of spider droppers out there.  Most require a microcontroller (like an Arduino Uno) and two actuators (for example, a motor to spool up the spider and a servo or solenoid to initiate the drop).  There are single-motor versions, but they require a reversing motor (which doesn't "drop" the spider so much as lower it) or a motor controller.

There's also at least one commercial "dropping spider" available at Halloween stores and party stores.  Those put the mechanism in the body of a comically unrealistic spider.

Although I enjoy programming and more complex projects, I wanted to make a spider dropper that required fewer parts (a.k.a. cheaper) and would be accessible to haunters who aren't interested in electronics, microcontrollers, and programming.

So I came up with the Stupidly Simple Spider Dropper.

("Stupidly Simple" refers to the design of the mechanism, not the haunters who use them.)

There are two configurations:

1. Stupidly Simple Spider Dropper AC
2. Stupidly Simple Spider Dropper DC

There is also a Slightly Smarter upgrade kit for the DC configuration.

## Assembly Instructions

### Stupidly Simple Spider Dropper AC

You will need:

| Part | Quantity | Notes |
| ---- | -------- | ----- |
| reindeer motor | 1 | clockwise and non-reversing |
| M3&times;16mm self-tapping screw | 4 | recommended |
| 608 bearing | 2 | commonly used in skateboards |
| fishing line | at least 3 feet | |
| toy spider | 1 | 
| drive gear | 1 | 3D print, specific to the reindeer motor |
| spool assembly | 1 | 3D print |
| base plate | 1 | 3D print |
| button | 1 | 3D print or use a small shirt button |
| 4-inch cable tie | 1 | |
| 8-inch cable tie | 2 | |

The reindeer motors are synchronous AC motors inside a plastic weather-resistant housing that turn clockwise at about 5 to 6 revolutions per minute.  The Mini Motors currently sold by Monster Guts and the Deer Motor sold by Fright Props are appropriate.  Versions  that run counterclockwise or that reverse if they hit resistance are not compatible with the design of the Stupidly Simple Spider Dropper.

You can assemble this configuration with the screws that come attached to the reindeer motor, but the recommended screws will hold the motor much more securely.  If you cannot find metric ones, you can substitute #6&times;3/4" sheet metal screws.

The spider must weigh at least a few ounces and probably less than 1 pound.

#### Attach the AC Motor

Unscrew the "hub" screw on the deer motor and remove any crank arm that came attached to the shaft.  Keep the hub screw for later.  (If you need to replace it, the hub screw is M4&times;10mm.)

There are ten screws around the perimeter of the motor housing.  Remove the four that are in the taller plastic pieces.

Place the base plate on the face of the motor, and align the four mounting holes in the base plate with the four mounting points in the motor.  (Ignore the other mounting holes; they are for the DC motor configuration.)

Screw the longer self-tapping screws through the base plate and into the motor mounts.

Route the power cord so that it extends past one of the short edges of the base plate and secure it with the small cable tie.  Trim the excess off the tie.  The idea is to keep the cord from interfering with any of the moving parts.

Check:
- [ ] The face of the motor housing should be flush with the back of the base plate.
- [ ] The motor shaft should extend through the center of the round hole in the base plate.
- [ ] The heads of the screws should be recessed into the base plate.
- [ ] The seam of the motor housing should be tight.  If one of the longer screws doesn't go in correctly, it may push the two parts apart.  If you see evidence of that, back the screw out and try driving it again.

Skip ahead to Attach the Drive Gear.

### Stupidly Simple Spider Dropper DC

You will need:

| Part | Quantity | Notes |
| ---- | -------- | ----- |
| 12V DC gearmotor | 1 | Aslong JGY-370 |
| 2.1mm barrel socket with leads | 1 | |
| M3&times;5mm machine screws | 5 | |
| 608 bearing | 2 | commonly used in skateboards |
| fishing line | at least 3 feet | |
| toy spider | 1 | 
| drive gear | 1 | 3D print, specific to the DC motor |
| spool assembly | 1 | 3D print |
| base plate | 1 | 3D print |
| button | 1 | 3D print or use a small shirt button |
| 4-inch cable tie | 1 | |
| 8-inch cable tie | 2 | |

I believe the Aslong JGY-370 motor is a "whitelabel" product, meaning the same manufacturer may produce compatible models that get branded differently from a variety of sellers and offering a range of speeds.

The motor must:

- [ ] Be rated for continuous operation at 12V DC.
- [ ] Have mounting holes that match the template in the build plate.
- [ ] Turn slower than 10 RPM.  The sweet spot is 6 RPM.

#### Attach the DC Motor

Temporarily connect 12V DC to the motor's terminals.  The shaft should turn clockwise.  If it turns the wrong way, swap the positive and negative wires and check again.  Once you have it turning clockwise, mark the positive terminal so you'll be able to wire it up correctly.

Note:  Some of the motors have a red dot by one terminal.  For most of them, that's the right terminal for the positive voltage.  But check.  If you have an unusual speed, the gearbox may be different, requiring that you use the opposite polarity.

Split the leads on the barrel socket about two inches.  Slip a half-inch length of heat-shrink tubing over each lead, sliding them away from the ends of the leads.  Solder the red lead to the positive terminal and the black one to the negative terminal.  Slide the tubing down over the exposed connections and use a heat gun to shrink them down.

Connect power to the barrel socket to check your work.

Place the base plate on the face of the motor, and align the four mounting holes in the base plate with the four mounting points in the motor.  (Ignore the other mounting holes; they are for the AC motor configuration.)

Screw four of the M3 machine screws through the base plate and into the threaded mounting holes around the motor shaft.  (A fifth screw will be needed as the "hub screw" in a subsequent step.)

Route the power cord so that it barrel socket is one of the short edges of the build plate and secure it with a small cable tie.  Trim the excess off the tie.  The idea is to keep the cord from interfering with any of the moving parts.

Check:
- [ ] The face of the gearbox housing should be flush with the back of the base plate.
- [ ] The motor shaft should extend through the center of the round hole in the base plate.
- [ ] The heads of the screws should be recessed into the base plate.

### Common Assembly

The rest of the installation is the same, regardless of the configuration.

#### Attach the Drive Gear

Make sure you have the drive gear that fits the shaft of your motor.  Note that the shaft has at least one flattened side and the hole in the center of the gear should match that.

Fit the drive gear onto the motor shaft.  The side with the arrow should be away from the motor.  When it's brand new, it may be a tight fit, so press firmly until the gear slides all the way onto the shaft.

Use the hub screw to hold the gear to the shaft.

Check:
- [ ] Plug in the motor to confirm that the gear turns in the direction indicated by the arrow.
- [ ] Look at the edge, the bottom face of the gear should be even with the wide base on the axle.  If it's higher, the gear hasn't been pressed all the way down the motor shaft.

#### Attach the Spool Assembly

Place one of the bearings flat on a table.

Press the spool assembly down over it so that the bearing becomes the hub of the geared portion of the spool assembly.  It should be a tight fit.  The face of the bearing should be flush with the face of the gear.

Place the second bearing on the table and press that in from the same side.  The first bearing should move into center of the spool, and the second bearing should become the hub of the gear.  Both bearings should be flush with the openings in the spool assembly.

Slide the spool assembly gear-first onto the axle on the build plate.  You will probably have to twist it back and forth a little as the gear teeth mesh.

Check:
- [ ] Looking at the edge, the small gear of the spool assembly should be all the way down on the base of the axle.
- [ ] The bottom of the drive gear should be even with the bottom of the small gear on the spool assembly.
- [ ] The spool should hang over the drive gear, but the two should not touch.
- [ ] Plug in the motor and let it run for a few revolutions.  Through most of one revolution of the drive gear, the spool assembly should turn in the direction shown by its arrow.

#### Attach the Spider

Feed one end of the fishing line through one hole on the button and then back through the other hole of the button and tie it off with a double knot.

Feed the other end through the hole on top of the spool assembly.  It will emerge from a hole in the groove of the spool.

Feed that through the hole in the guide (from inside to outside).

Pull all the slack until the button is flush against the top of the spool.

Temporarily tie the spider to the fishing line at least two feet below the guide.

Suspend the mechanism using the larger cable ties through the openings at the top of the base plate.  It should be high enough that the spider dangles but not so high that it's difficult to access the mechanism.

Run the mechanism to test the position of the spider along the line.  If the spider hits the guide, cut the power and re-tie it lower on the string.

Once you've watched it run for a few cycles and you're satisfied with the position, you can attach the spider permanently using the method of your choice.  For small plastic spiders, I drill a small hole into the back of the abdomen near the spinerets, insert the end of the line, and then fill the hole with black hot glue.

## History

I created a set of 3D printable parts to which you can attach a "reindeer" motor and a toy spider.  When you plug it in, it draws the spider up, drops it, and repeats.  A whole cycle takes about 10 seconds.  My hope was that the dropper would be simple and inexpensive enough that a haunter could deploy a few of them in a spider invested haunt to create creepy ambient motion rather.

I gave out a couple to fellow haunters and learned that, while the basic idea was sound, in practice the mechanism was prone to jamming.  I also received feedback from a haunter who said he would prefer one that runs on a DC motor rather than an AC motor.  Personally, I was unhappy how the mechanism seemed to amplify the sound of the motor, and I had growing concerns about how repeated drops might weaken the mechanism over time.

So I went back to the drawing board.  I solved most of the jamming problems, made it somewhat quieter, beefed up some of the weaker parts.  I also made it possible to build with either an AC reindeer motor (as before) or a 12V DC low RPM gearmotor (JGY-370).

(One 3D-printed part still depends on which motor you choose.  I'm hoping to make it motor-agnostic and to instead provide two small adapters as part of the kit.)

As I watched them run through cycle after cycle, I began to desire a jumpscare version that dropped only when triggered would be cool.  After some R&D, I found a way to do that without adding a microcontroller.

So I developed a "Slightly Smarter" spider dropper upgrade kit.  It's a small circuit board that screws onto the "Stupidly Simple" mechanism and uses a motion sensor (HC-SR312 or clone).  Previously, I'd developed a kit to make these general purpose PIR motion sensors more useful for triggering effects in a haunt environment, and I was able to leverage what I'd learned and designed directly into the Slightly Smarter upgrade.

Refinement continues on both the Stupidly Simple mechanism and the Slightly Smarter upgrade.
