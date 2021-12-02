# Using NikonScope (Last Updated 6/17/2020)

## A Note on Hardware

The code for this project currently works for the Nikon Eclipse TE2000-E microscope with the T-HUBC HUB controller. It may work for similar 
hardware, but, if not, can be modified accordingly.

## Connecting to the Microscope

To open connection to the microscope, run the command

`scope = scope_open`

By default, *the code assumes that the scope is connected to the COM2 port*. If the scope is to be connected to a different serial port,
make sure to change it in the `scope_open` source code.

## Controlling the Lamp

In order to automate microscope control, make sure that the light above the "REMOTE" button in the "DIA LAMP" section of the remote interface
is green. Otherwise, the microscope will assume you intend to use manual control and your commands will not go through.

To determine if the lamp is on or off, run 

`state = scope_get_lamp_state(scope)`

To turn the lamp on or off, run 

`scope_set_lamp_state(scope, state)`

In both `scope_get_lamp_state` and `scope_set_lamp_state`, `state = 0` corresponds to the lamp being off and `state = 1` corresponds to the lamp being on.

The brightness of the lamp can be adjusted through adjusting the lamp voltage. The lamp voltage, when on, takes on values in the range [3, 12].

To check the lamp voltage, run

`voltage = scope_get_lamp_voltage(scope)`

To change the lamp voltage, run

`scope_set_lamp_voltage(scope, voltage)`

It should be noted that the above command should ONLY be run when the lamp is on. Additionally, if the input parameter `voltage` is not in the range [3, 12]
an error will result.

## Controlling the Focus

The values that the focus position can take range from 0 to somewhere in the 10000s range. Since this range is very large, it is not practical to manually 
key in the values to find the optimal focus manually. It is better to run the following autofocus routine below:

`focus_scores = ba_findfocus(scope, [min_focus_val max_focus_val], stepsize, exptime)`

The outputted graph will indicate which focus position has the best focus, which you will have to manually move to. Note that the above function is made 
to handle images of flourescent beads when viewed using the LED driver, NOT for imaging fiducial markings under the scope lamp. 

To check the current position of the focus, run

`focus = scope_get_focus(scope)`

To change the focus position, run

`scope_set_focus(scope, focus_value)`

You can also change the step size of the focus if you would like. Changing the stepsize has a negligible effect on speed, so it is recommended that you 
use the finest setting. Note that the step size can either be coarse (step_size = 0), medium (step_size = 1), or fine (step_size = 2).

To check the step size of the focus, run

`step_size = scope_get_focus_res(obj1)`

To change the step size of the focus, run

`res = scope_get_focus_res(obj1)`

## Changing the Optical Path

More than one camera can be attached to the microscope at a time. To switch between them is to switch the optical path. 

You can check which optical path you are on by running the following:

`path = scope_get_op_path(scope)`

where `path` is the path number of the optical path. 

To change the optical path you are on, run

`scope_set_op_path(scope, path)`

## Closing Connection to the Microscope

For good practice, close the connection to the microscope after use with the following:

`scope_close(scope)`

In some cases, if connection to the scope is not closed properly, `scope_open` will return an error the next time it is run. If such an error
is encountered, turn on and off the microscope and try again. 
