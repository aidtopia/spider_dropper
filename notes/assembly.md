# Stupidly Simple Spider Dropper<br>Assembly Instructions

Adrian McCarthy (2026) for the [Northern California Haunters Group](https://www.norcalhaunters.com/).

All project source files and documentation are available at https://github.com/aidtopia/spider_dropper.


## Three Models

There are three models of the spider dropper.  Make sure you know which kit you have.

* Stupidly Simple Spider Dropper AC `#SSSDAC`

  This model requires the fewest part and uses a "reindeer" motor that plugs in to regular household power.  Both Fright Props and Monster Guts sell these as "small prop motors."

* Stupidly Simple Spider Dropper DC `#SSSDDC`

  This is the same idea, for haunters that prefer to run their props with DC power.  It's designed around a widely available, inexpensive 12-volt DC gearmotor.  The kit does not include a power supply because you probably already have one.  Requires soldering two connections, making it about as simple as the AC version.

* Slightly Smarter Spider Dropper Upgrade `#SSSDUP`

  This is the DC version of the dropper plus some electronics to transform it from a continuously cycling effect to one that triggers on motion.  Assembly requires soldering some components to a circuit board (through hole, not surface) and using a cable to connect it to an inexpensive PIR module.

Skip any instructions tagged for a model different than the one you're building.  Sections with no tag apply to all models.

## Safety

* The kit contains small parts that could be a choking hazard.
* Children should assemble the kit or use the spider dropper only under adult supervision.
* Some parts may contain hazardous substances.  In particular, the circuit boards contain lead.  Wash your hands with soap and water after handling.
* Soldering irons, heat guns, and other tools used in assembly have their own risks.  Take appropriate precautions.
* Intended for indoor use.  (`#SSSDAC` uses a motor in a weather resistant housing, so it may withstand light exposure to the elements.)
* Do not use if the power cord or power supply is damaged.
* `#SSSDAC` uses household electric current.  To reduce the risk of electric shock, never open the weather-resistant motor housing.
* `#SSSDDC` and `#SSSDUP` require a 12 VDC power supply.  Use an ETL- or UL-listed power adapter with a current rating of at least 250 mA.
* Do not operate unattended.  If the mechanism jams, the motor could overheat.
* Refer to the User Guide for important precautions regarding the setup and operation of the spider dropper.
* Disposal:  The circuit board and soldered components, including the PIR motion module, should be treated as e-waste.  If undamaged, the motor can be re-used in another project.  Otherwise it too should be treated as e-waste.  Printed parts may be recyclable but won't be accepted by most collection programs.

## Tools

| Tool                           | `#SSSDAC` | `#SSSDDC` | `#SSSDUP` |
| :----------------------------- | :-------: | :-------: | :-------: |
| Philips #1 screwdriver         | required  | required  | required  |
| wire cutters                   | required  | required  | required  |
| soldering iron                 |           | required  | required  |
| wire stripper                  |           | required  | required  |
| heat gun (heat-shrink tubing)  |           |recommended|recommended|
| needle nose pliers or tweezers |recommended|recommended|recommended|
| crimping pliers (Dupont)       |           |           | required  |
| crimping pliers (JST XH)       |           |           | required  |
| small adjustable wrench        |           |           |recommended|
| bearing removal tool `#3D`     | optional  | optional  | optional  |
| soldering jig `#3D`            |           |           | optional  |

These additional tools can be helpful for attaching the spider.

* measuring tape or ruler
* drill with 1/8" bit
* hot glue gun (preferably with black glue)

## Parts

For detailed specifications and possible sources for the parts, check the spreadsheet in the project files on Github.

Parts tagged with `#3D` are ones you can print with a 3D printer.  See Tips for the Printable Parts.

**NorCal Haunters**:  The Make & Take kit does _not_ include a power supply for `#SSSDDC` or `#SSSDUP`.  Some will be available at the event for testing.  In your haunt, you will need an AC to DC power adapter that delivers 12 volts and is rated for at least 250mA.

| Part                           | `#SSSDAC` | `#SSSDDC` | `#SSSDUP` |
| :----------------------------- | :-------: | :-------: | :-------: |
| "reindeer" motor               |     1     |           |           |
| M3x16mm sheet metal screws     |     4     |           |           |
| 7mm shaft adapter `#3D`        |     1     |           |           |
| JGY-370 12VDC motor 6 RPM      |           |     1     |     1     |
| 2-wire motor "pigtail"         |           |  barrel   |  JST XH   |
| 6mm shaft adapter `#3D`        |           |     1     |     1     |
| M3 threaded insert<sup>\*<sup> |     1     |     1     |     1     |
| M3x6mm machine screws          |     1     |     5     |     6     |
| base plate `#3D`               |     1     |     1     |     1     |
| spool assembly `#3D`           |     1     |     1     |     1     |
| 608 (skateboard) bearing       |     2     |     2     |     2     |
| drive gear `#3D`               |     1     |     1     |     1     |
| hub screw `#3D`                |     1     |     1     |     1     |
| fishing line (3+ feet)         |     1     |     1     |     1     |
| toy spider                     |     1     |     1     |     1     |
| M3 square nut                  |           |           |     1     |
| small zip ties                 |     1     |     2     |     2     |
| medium zip ties (for hanging)  |     2     |     2     |     2     |
| 12VDC power supply             |           | not incl. | not incl. |

<sup>\*</sup> There are three options for the threaded insert.  Choose the one that matches your shaft adapter (or choose the shaft adapter to match your insert).  Any option works well for a small toy spider.  For anything heavier, choose the highest one available to you.

* M3s×5mm heat-set insert
* M3 _thin_ square nut (~1.8mm thick)
* M3 _regular_ square nut (~2.4mm thick)

Note that `#SSSDUP` requires an M3 square nut in addition to whichever part you use for the threaded insert.

**Norcal Haunters:**  I've pre-installed heat-set threaded inserts in the shaft adapters in your Make & Take kits.

---

#### Slightly Smarter Upgrade

The `#SSSDUP` is the `#SSSDDC` _plus_ a circuit and a sensor.

`#SSSDUP`: Circuit Parts

| Quantity | Part                                           |
| -------: | :--------------------------------------------- |
|        1 | Slightly Smarter printed circuit board         |
|        1 | PJ-044AH vertical barrel connector (female)    |
|        1 | 250 mA PTC resettable fuse                     |
|        1 | 100K-ohm resistor                              |
|        1 | 1N4001 diode                                   |
|        1 | IRLZ3FN n-channel MOSFET                       |
|        1 | 2-pin JST XH (male) connector (PTH mount)      |
|        1 | 3-pin JST XH (male) connector (PTH mount)      |
|        1 | ZX40E20C01 microswitch                         |
|        1 | additional M3x5mm machine screw                |
|        1 | additional M3 square nut (thin or regular)     |

`#SSSDUP`:  Sensor Parts

| Quantity | Part                                           |
| -------: | :--------------------------------------------- |
|        1 | mini-PIR motion sensor                         |
|        1 | PIR housing `#3D`                              |
|        1 | PIR cap `#3D` (snoot version recommended)      |
|        1 | PG7 cable gland                                |
|        1 | 3-conductor 22-26AWG stranded jacketed cable   |
|        3 | Dupont-style header pins (female) and housing  |
|        3 | JSX XH header pins (female) and housing        |

## Assembly

### Print the Printable Parts

**NorCal Haunters:** The Make & Take kits come with the printed parts, so you may proceed to the next section.

The project source files on GitHub include the OpenSCAD sources for generating the 3D models as STL files.  The pre-generated models will be available on Printables. [TODO]

The 3D parts are designed to be printed with a 0.4mm nozzle.  They've all been tested with Prusa MK3S+ and CORE One+ using both PLA and PETG.  None of them require supports.

The hexagonal pattern of the base plate has several advantages for the design, but it can make be challenging to print on some printers.  Make sure you have your first-layer settings dialed in.

Recommendations:

* Prefer PETG instead of PLA for a more durable mechanism.

* The shaft adapter and hub screw should be printed together to ensure a good fit.

* I recommend printing the shaft adapter with 100% infill, especially if you're using the version with the heat-set insert.

* Parts without threads (base plate, drive gear, spool assembly, optional tools) can be printed with a larger layer height of 0.3mm for speed.

* Parts with threads (shaft adapter, hub screw, sensor housing) should be printed with a layer height of 0.2mm or smaller.  Choose quality over speed for these parts.

* Test fit threaded parts before assembly.  Tightening and loosening them a few times will wear away any imperfections in the printing of the threads.

Print:

- [x] base plate
- [x] drive gear
- [x] spool assembly
- [x] shaft adapter and hub screw (100% infill, layers <= 0.2mm, quality over speed)
- [x] bearing tool (optional)
- [x] `#SSSDUP` sensor housing and cap
- [x] `#SSSDUP` soldering jig (optional)

### Prepare the Shaft Adapter

Note that the shaft adapter comes in two sizes, one for the reindeer motor and one for the DC motors.  Hereafter, "shaft adapater" means whichever one is appropriate for your model.

The adapter is the weak link in the mechanics.  Should the mechanism jam, the adapter will likely deform, allowing the motor to run freely to prevent an overload.  If this happens, print a new adapter to replace the deformed one.

- [ ] Test fit the 3D-printed hub screw in the top of the adapter to break out any stringiness or imperfections with the threads.
- [x] Insert the appropriate nut or heat-set insert into the shaft adapter.
- [ ] Screw one M3x6mm screw into the adapter.  (This is the "set screw.")

**NorCal Haunters:** Heat-set inserts have been pre-installed in the Make & Take kits.

### Prepare the Motor

#### `#SSSDAC`

- [ ] Confirm the reindeer motor turns clockwise and does not auto-reverse if obstructed.
- [ ] Remove the four mounting screws from the motor.  [See diagram.]

> Do not remove any of the other screws that secure the weather resistent housing.

#### `#SSSDDC` or `#SSSDUP`

Some motors come with a red dot next to one terminal.  This may or may not indicate the correct polarization for this project, so check it first.

- [ ] Temporarily connect 12VDC to the terminals of the DC motor.
- [ ] If it turns counterclockwise, reverse the polarity of the power.
- [ ] If it turns clockwise, mark the terminal connected to the red wire.
- [ ] Disconnect the power.

For `#SSSDDC`, the pigtail has a barrel connector that fits the output of your power supply.  For `#SSSDUP`, the pigtail has a small plastic connector that will plug into the circuit board.

- [ ] Slip a short length of heatshrink tubing onto each of the pigtail wires.
- [ ] Solder the red wire of the pigtail to the marked terminal.
- [ ] Solder the black wire to the other terminal.
- [ ] Slide the tubing over the exposed connections and shrink them down.

#### All Models

- [ ] Remove any crank or hub that came with the motor.
- [ ] Loosen the shaft adapter screw until no part of it is visible in the shaft bore.
- [ ] Slip the shaft adapter over the motor shaft as far down as it will go.
- [ ] Twist the adapter until the set screw is perpendicular to the flat side of the motor shaft.
- [ ] Tighten the set screw against the shaft as tightly as you can with a manual screwdriver.  Ensure the shaft adapter remains all the way down as you tighten.
- [ ] With the motor shaft pointing up, slip the base plate over the motor so the shaft adapter fits through the largest hole.
- [ ] Align the motor mounting holes on the base plate with the ones on the motor.

#### `#SSSDAC`

- [ ] Use 4 M3×16mm self-tapping screws to attach the motor to the base plate.

> Tip:  Work carefully and screw them in slowly while applying firm pressure.  Repeated insertions of the self-tapping screws will wear out the plastic.

#### `#SSSDDC` and `#SSSDUP`

- [ ] Use 4 M3×6mm machine screws to secure the motor to the base plate.

### Solder the Slightly Smarter Circuit (`#SSSDUP` only)

- [ ] Solder the 100K resistor (brown/black/yellow) at R1.
- [ ] Solder the 1N4001 diode at D1 with the striped end as marked on the board.
- [ ] Trim the excess leads.
- [ ] Carefully bend the legs of the MOSFET by 90 degrees and solder at Q1 (see diagram).
- [ ] Solder the 3- and 2-pin JST XH connectors at J1 and J3, respectively. Match the orientation to the markings on the board.
- [ ] Solder the PTC fuse at F1, being careful not to overheat it.
- [ ] Trim the excess leads.
- [ ] Solder the barrel connector at J1.

The microswitch will be installed on the opposite side of the board from all the other components.

It must be positioned flat against the board with the lever toward the middle of the board as indicated.

- [ ] Solder the microswitch into position.

> Tip:  You can 3D print a jig that holds the microswitch in the correct position while soldering.  Fit the switch into position on the board, and slide the jig over the switch until the board is flush with the jig.  Turn them both over so the jig is beneath the board and set it flat on your worksurface. Solder one terminal of the switch while applying some downward pressure to keep the board against the jig and the switch lever compressed.  Check that the switch is straight and parallel before soldering the other two terminals.

- [ ] Place the circuit onto the base plate with the components on the motor side the switch on the axle side.
- [ ] Secure the circuit board with an M3x6mm screw and a square nut in the pocket.

> Tip:  Match the triangular arrow printed on the board and to the one embossed on the build plate to get the correct orientation.  Slide that edge of the board under the lip first.

### Make the Sensor Cable (`#SSSDUP` only)

**NorCal Haunters**:  The Make & Take kits have the sensor cable mostly pre-made.  You're welcome.

- [x] Slide a 1- to 2-inch section of heat shrink tubing onto the cable.  Do not shrink it yet.
- [x] Remove about 1.5 inches of the jacket from one end of the cable, being careful not to nick the insulation on the wires inside.
- [x] Strip about 2 mm from the tips of each of the exposed wires.
- [x] Crimp the JST XH pins (female) onto the wires.
- [x] Insert the pins into the JST XH housing in RED/YELLOW/BLACK order, starting with RED closest to the notch in the housing.
- [x] Shrink the tubing over the cable jacket, near where you cut it away.  This will provide some additional cushion when you later cinch it down with a cable tie.

- [x] Slide another 1- to 2-inch section of heat shrink tubing onto the cable from this end.
- [x] Remove about 1.5 inches of the jacket from the other end of the cable.
- [x] Strip about 2 mm from the tips of each of the exposed wires.
- [x] Crimp the Dupont-style pins (female) onto the wires.  Do not yet put them into the connector housing.
- [x] Shrink the tubing so that the center of the length is 2 inches from the tips of the Dupont pins.  This will provide some cushion where the cable gland clamps the cable.

- [ ] Remove the flat nut from a cable gland.  You won't need it.
- [ ] Screw the gland into the back of the 3D-printed sensor housing.

> Tip:  Imperfections in the print could make screwing the gland to the housing difficult.  Tighten and loosen a few times to clear out the threads.  A small adjustable wrench can be useful for holding the gland.

- [ ] Remove the round nut from the cable gland.
- [ ] Slip the Dupont pins into the rounded end and let the nut slide up the cable.
- [ ] Feed the Dupont pins into the gland.  Be careful not to dislodge the rubber seal held at the tips of the fins.
- [ ] When the pins extend out the top of the sensor housing, insert them into the Dupont connector housing in RED/YELLOW/BLACK order, starting at either end.

- [ ] Insert the PIR sensor module into the Dupont connector, ensuring that the pin marked `+` or `VIN` corresponds to the RED wire.

> Tip:  If the dome pops off the PIR module, be careful not to touch the exposed sensor.  Replace the dome and hold it in place until it's secured into the housing.

- [ ] Push gently on the dome of the PIR module until the brim is flat against the rim of the housing.

> Tip:  Do not pull the module into the housing from the cable, as that may loosen the connection.

- [ ] Screw the cap onto the sensor housing.  When tightened, it pinches the brim of the dome, holding the module secure inside the housing.
- [ ] Slide the round nut up the cable and back onto the cable gland and hand tighten.
- [ ] Set the sensor and cable aside for now.

### Install the Spool

- [ ] Place one bearing on a strong, flat surface.
- [ ] Position the wide face of the spool over the bearing and press down firmly until the bearing is inside the bore.
- [ ] Repeat with the second bearing.

Both bearings should be aligned and flush with the spool at both ends of the bore.  If not, you can use the bearing removal tool to pop the bearings out and try again.

- [ ] Slide the spool onto the axle so that the wider part is closer to the base plate.
- [ ] Check that the spool can spin and that it doesn't wobble or rub the plate.

### Install the Drive Gear

- [ ] Press the drive gear onto the shaft adapter so that the arrows are on top, and the toothless section is closest to the small gear of the spool.
- [ ] Confirm that the flat surface of the gear is flush with the top of the shaft adapter.
- [ ] Turn the spool and confirm it doesn't rub against the drive gear.
- [ ] Screw the hub screw into the shaft adapter and hand tighten.

The hub screw ensures the drive gear won't work its way off of the shaft adapter, and the drive gear, in turn, ensures the spool won't work off of its axle.

### Attach the Fishing Line

The base plate has two string guides at the edges near the spool.  Decide whether you will hang the mechanism horizontally or vertically.  You will use the guide that's below the spool when hanging.

- [ ] Feed one end of the fishing line through the guide toward the spool.
- [ ] Thread the fishing line into one of the holes along the edge of the spool.
- [ ] Route the fishing line through one of the two holes in the bar that divides the recess.
- [ ] Route the line back through the other hole.
- [ ] Tie the line with a double knot.
- [ ] Ensure the string remains entirely within the recessed part of the spool.

### Prepare the Spider

To make the toy spider hang realistically ...

- [ ] Trim a short zip tie about 1/2 to 3/4" down from the end with the loop.
- [ ] Select a drill bit that's as wide as the zip tie.  It's better to err too small than too large.
- [ ] Carefully drill a hole in the back of the abdomen (just below the spinnerets) of the spider toward its center of mass.  The hole needn't be longer than the trimmed zip tie.
- [ ] Dip the zip tie in a blob of hot glue (use the black "cosplay" glue if you can).
- [ ] Insert the zip tie into the hole so that only the loop protrudes.  Ideally the glue should fill any gap between the zip tie and the sides of the hole.
- [ ] Allow the hot glue to cool, then check that zip tie is secure.

### Attach the Spider

There must be at least 24 inches of line between the bottom of the string guide and the point where the spider is tied.

- [ ] Tie the free end of the fishing line to the spider through the loop in the zip tie, with a double knot.
- [ ] Keeping some tension on the string, wind the spool 2.5 revolutions in the direction shown by the arrows.  If the spider reaches the guide before you complete the turns, the spider was tied too high.
- [ ] Trim the excess fishing line.

### Final Connections `#SSSDUP`

- [ ] Plug the motor pigtail into the 2-pin connector on the circuit board.
- [ ] Use a small zip tie to secure the pigtail to the base plate as shown.
- [ ] Plug the sensor into the 3-pin connector on the circuit board.
- [ ] Use a small zip tie to secure the cable to the base plate as shown.

### Test the Mechanism

- [ ] Suspend the mechanism as shown in the diagram.
- [ ] Allow the spool to fully unwind and that spider to dangle.
- [ ] Connect the power.

`#SSSDAC` and `#SSSDDC`:  The spider should rise and then drop suddenly.  The cycle should repeat continuously.

`#SSSDUP`:  The spider should rise to its highest point, and then stop until the sensor detects motion.  When that happens, the spider will drop suddenly, and then rise again.

- [ ] Confirm the line winds in an orderly fashion around the spool.
- [ ] Confirm the drive gear doesn't rub against the spool.
- [ ] Confirm the spider drops the full amount.
- [ ] Allow the mechanism to run for several cycles to ensure it is not prone to jamming.

## Happy Haunting

You've completed assembly of the Stupidly Simple Spider Dropper.

Please consult the User Guide for tips on setting up and operating the spider dropper in your haunt.  In particular, it has important information on avoiding and dealing with a jam.
