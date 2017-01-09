# Z Axis

- TODO link table of contents
- TODO build plate !

## BOM
| Quantity | Name |
| :---: | --- |
| 4 | [Z carriage](#) | 
| 2 | [Motor holder](#) | 
| 2 | [Belt tensioner](#) | 
| 8 | [Z frame fix](#) (4 mirrored) |
| 2 | [GT2 Belt](../bom/bom.md) loop 1524mm |

### Z carriage x 4
#### BOM
##### Bearings
| Quantity | Name |
| :---: | --- |
| 4 | [M3 screw](../bom/bom.md) 16mm | 
| 16 | [M3 washer](../bom/bom.md) | 
| 4 | [M3 self locking nut](../bom/bom.md) | 
| 4 | [623ZZ bearing](../bom/bom.md) | 

##### Lead nut
| Quantity | Name |
| :---: | --- |
| 4 | [M3 screw](../bom/bom.md) 16mm | 
| 4 | [M3 nut](../bom/bom.md) | 
| 1 | [Threaded rod lead nut](../bom/bom.md) | 

##### Fixing
| Quantity | Name |
| :---: | --- |
| 4 | [M3 screw](../bom/bom.md) 16mm | 
| 4 | [M3 nut](../bom/bom.md) | 

#### Print details
* Files: [carriage_z_back.stl](../../models/XYZ/Z/carriage/carriage_z_back.stl), [carriage_z_front.stl](../../models/XYZ/Z/carriage/carriage_z_front.stl)
* Time: 2h x 2
* Layer height: 0.2mm
* Weight: 13g x 2
* Support: No
* Infill: 50%

#### Build steps
<a href="./DSC_0041.JPG"><img src="./DSC_0014.JPG" height="500"></a>
<a href="./DSC_0042.JPG"><img src="./DSC_0015.JPG" height="500"></a>
<a href="./DSC_0043.JPG"><img src="./DSC_0043.JPG" height="500"></a>

### Motor holder x 2
#### BOM
##### Motor
###### High torque (recommended, can lift ~16kg)
| Quantity | Name |
| :---: | --- |
| 1 | [Nema 17 with gearbox](../bom/bom.md) | 
| 1 | [GT2 pulley](../bom/bom.md) 20 teeth 8mm bore | 
| 4 | [M3 screw](../bom/bom.md) 35mm | 
| 4 | [M3 washer](../bom/bom.md) | 

###### Low torque (alternative, can lift ~4kg)
| Quantity | Name |
| :---: | --- |
| 1 | [Nema 17](../bom/bom.md) | 
| 1 | [GT2 pulley](../bom/bom.md) 20 teeth 5mm bore | 
| 4 | [M3 screw](../bom/bom.md) 8mm | 
| 4 | [M3 washer](../bom/bom.md) | 

##### Fixing
| Quantity | Name |
| :---: | --- |
| 4 | [M3 screw](../bom/bom.md) 8~10mm | 
| 4 | [M3 washer](../bom/bom.md) | 
| 4 | [M3 self locking nut](../bom/bom.md) | 

#### Print details
##### Motor block
* File: [motor_block.stl](../../models/XYZ/Z/motor_block/motor_block.stl)
* Time: 1h50
* Layer height: 0.2mm
* Weight: 22g
* Support: No

##### Gearbox adatper (high torque)
* File: [motor_gearbox_adapter.stl](../../models/XYZ/Z/motor_block/motor_gearbox_adapter.stl)
* Time: 40m
* Layer height: 0.2mm
* Weight: 4g
* Support: No

#### Build steps
<a href="./DSC_0035_2.JPG"><img src="./DSC_0035_2.JPG" height="500"></a>
<a href="./DSC_0044.JPG"><img src="./DSC_0044.JPG" height="500"></a>


### Belt tensioner x 2
#### BOM
| Quantity | Name |
| :---: | --- |
| 3 | [Pulley](../pulley/pulley.md) |
| 4 | [M3 screw](../bom/bom.md) 30mm | 
| 1 | [M3 screw](../bom/bom.md) 20mm | 
| 6 | [M3 washer](../bom/bom.md) | 
| 7 | [M3 nut](../bom/bom.md) | 
| 1 | [M3 self locking nut](../bom/bom.md) | 
| 1 | [M3 butterfly nut](../bom/bom.md) | 

#### Print details
* File: [motor_block_pulley_holder_bot.stl](../../models/XYZ/Z/motor_block/motor_block_pulley_holder_bot.stl), [motor_block_pulley_holder_top.stl](../../models/XYZ/Z/motor_block/motor_block_pulley_holder_top.stl), [pulley_holder.stl](../../models/XYZ/Z/motor_block/pulley_holder.stl)
* Time: 40min + 40min + 5min
* Layer height: 0.2mm
* Weight: 7g + 7g + 1g
* Support: No

#### Build steps
<a href="./DSC_0004.JPG"><img src="./DSC_0004.JPG" height="500"></a>
<a href="./DSC_0006.JPG"><img src="./DSC_0006.JPG" height="500"></a>
<a href="./DSC_0007.JPG"><img src="./DSC_0007.JPG" height="500"></a>

Take time to adjust the space beetween this part and the motor bloc. Maybe you'll need to add more washes.
<a href="./DSC_0008.JPG"><img src="./DSC_0008.JPG" height="500"></a>
<a href="./DSC_0009.JPG"><img src="./DSC_0009.JPG" height="500"></a>
<a href="./DSC_0011.JPG"><img src="./DSC_0011.JPG" height="500"></a>
<a href="./DSC_0046.JPG"><img src="./DSC_0046.JPG" height="500"></a>


### Frame fix x 8 (4 mirrored)

#### BOM
##### For a pair of fixations (top and bottom)
| Quantity | Name |
| :---: | --- |
| 1 | [Aluminum bar](../bom/bom.md) 16mm x 16mm x Xmm (1.5mm thickness) |
| 1 | [Threaded rod](../bom/bom.md) 8mm x 580mm |

##### For individual fixation
| Quantity | Name |
| :---: | --- |
| 4 | [M3 screw](../bom/bom.md) 8~10mm or 35mm |
| 3 | [M3 screw](../bom/bom.md) 16mm |
| 4 | [M3 washer](../bom/bom.md) |
| 3 | [M3 nut](../bom/bom.md) |
| 4 | [M3 T nut](../bom/bom.md) |
| 1 | [608ZZ bearing](../bom/bom.md) |
| 1 | [Thrust bearing 8mm](../bom/bom.md) |
| 1 | [GT2 pulley (20 teeth 8mm bore)](../bom/bom.md) |

#### Print details
* Files: [rod_fix_z_bot.stl](../../models/XYZ/Z/rod_fix_z/rod_fix_z_bot.stl), [rod_fix_z_top.stl](../../models/XYZ/Z/rod_fix_z/rod_fix_z_top.stl)
* Time: 1h30 + 40m
* Layer height: 0.2mm
* Weight: 32g
* Support: No
* Infill: 50%

#### Build steps
<a href="./DSC_0038.JPG"><img src="./DSC_0038.JPG" height="500"></a>
<a href="./DSC_0040.JPG"><img src="./DSC_0040.JPG" height="500"></a>
<a href="./DSC_0039.JPG"><img src="./DSC_0039.JPG" height="500"></a>

##### Infos
* The top is the same as the bottom (thrust bearing and GT2 pulley) except that the belt goes only on the bottom.
* It's not visible on the pictures, but there's too a GT2 pulley on the top. The purpose is to limit the movements of the rod on the Z axis.

