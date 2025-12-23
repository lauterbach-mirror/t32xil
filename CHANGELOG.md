 # Changelog

All notable changes to the TRACE32 XIL will be documented in this file. This project adheres to [Semantic Versioning]((http://semver.org/spec/v2.0.0.html).

## [6.23] - 2025-10-24

### Added
- Add support for MATLAB R2026a

## [6.22] - 2025-09-19

### Added
- Add support for MATLAB R2025b

### Fixed
- Fix callback execution with UDP connections
- Fix error "Installation is corrupted." on Linux platforms

## [6.21] - 2025-01-20

### Added
- Add support for MATLAB R2025a

## [6.20] - 2025-01-08

### Fixed
- Fix use of template makefiles for R2023b, R2024a and R2024b.
- Fix sporadic crashes during simulation runs
- Fix crashes if configuration parameters are left empty
- Fix extraction of Remote API parameters
- Fix buffer overflow during target to host communication

## [6.19] - 2024-07-25

### Added
- Add support for MATLAB R2024b

### Fixed
- Fix code navigation inside subsystems

## [6.18] - 2024-04-12

### Added
- Add Linux support

### Fixed
- Fix registration of Arm toolchains
- Fix model-to-code navigation

## [6.14] - 2024-01-08

### Added
- Add support for MATLAB R2024a

## [6.13] - 2023-09-21

### Added
- Add support for MATLAB R2023b

### Fixed
- Prevent symbol name conflicts in target executables..

## [6.12] - 2023-01-25

### Added
- Add support for MATLAB R2023a

### Fixed
- Fix toolchain registry for MATLAB R2022a and R2022b.

## [6.11] - 2022-07-28

### Added
- Add support for MATLAB R2022b
- Add Renesas CC-RL as custom toolchain for RL78

### Fixed
- Improve graceful shutdown of TRACE32 connection
- Improve robustness of relative configuration file paths

### Changed
- All included custom build toolchain configuration are set to transform paths with whitespaces
- Use Remote API to detect open TRACE32 instances

## [6.6] - 2022-01-18

### Added
- Add support for MATLAB R2022a
- Add support for AUTOSAR Adaptive System Target File
- Add configuration flag for TRACE32 Remote API communication timeouts

### Fixed
- Fix model-to-code navigation for R2018b
- Fix transmission errors while executing TRACE32 Remote API commands

### Changed
- Support selection of TRACE32 configuration files via relative paths
- Improve error message in case Remote API shared library is missing

## [6.2] - 2021-11-24

### Added
- Add HighTec compiler as custom toolchain for TriCore

## [6.1] - 2021-10-07

Initial release on GitLab/GitHub
