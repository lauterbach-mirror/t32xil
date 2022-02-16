![TRACE32 PIL Testing](https://gitlab.com/lauterbach/resources/raw/master/img/t32xil_banner_900x182.jpg)

## Overview

Lauterbach supports a wide range of processor architectures with its TRACE32 debug and trace tools. Its fully integrated add-on for Simulink implements a customizable workflow to streamline the setup of processor-in-the-loop (PIL) tests for a multitude of different targets. The open software interface of TRACE32 enables a seamless integration into existing toolchains. With a set-up and integrated TRACE32 the PIL tester has access to the complete TRACE32 feature set during model-based testing.

The key benefits are:
- Plug and play target support
- Built-in support for various build toolchains
- IEC 61508 compliant unit testing
- On-the-fly debugging 

Tested for use with MATLAB R2010b and newer.


### Hardware-based Verification

TRACE32 provides debug support for more than 80 microprocessor architectures including:
- TriCore
- Arm/Cortex
- Power Architecture
- RH850

Combining uniform base modules with architecture-specific probes helps to protect the long-term investment in the toolchain and simplifies the portability between different target environments.

During PIL testing TRACE32 is used as an abstraction layer by the modeling environment providing unified access to the target and rendering any target-specific adaptions on both host- and target-side effectively obsolete. Any target featuring basic debug supported becomes an eligible platform for model-based testing. In addition, the full set of TRACE32`s advanced debug and trace features becomes available.


### Test Virtualization

TRACE32 can be used as debug front-end for virtual prototypes, core simulators and target servers offering support for common virtualization interfaces and a familiar user experience via its uniform GUI.

Integrated instruction set simulators are available for a majority of the supported microprocessor architectures.


### Debugging Within Simulink

The add-on offers native debugging between Simulink models and TRACE32. Selecting an element of the model allows quick navigation to the associated source code section within TRACE32 and vice versa. Simulation runs at model level can be synchronized with the code exectution on the target by setting breakpoints.
