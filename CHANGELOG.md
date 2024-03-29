 # Changelog

All notable changes to the TRACE32 Verification and Validation Suite will be documented in this file. This project adheres to [Semantic Versioning]((http://semver.org/spec/v2.0.0.html).

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
