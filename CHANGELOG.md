
# Changelog

## [Unreleased] - 21/6/13 -> 21/??/??
### Added
- Pause menu (Can't select anything)
### Removed
- Deleted Sprite_legacy.inc and monochromeOLDGUI.asm as backups have been made if necesary
### Changed
- Heavy refactorization
- Split player_controls.inc, memory.inc, and movement_overworld.inc into seperate files
- Changed set and polling input functions to work with action buttons as well
### Bugs
- Polling can't tell the difference between a tap or a hold.
- Animation stops prematurely when stoppping to walk.
- Tapping causes walking animation to start

## [0.1.0] - 21/6/6 -> 21/6/13
### Changed
- Refactored a lot of the code base to better fit with my evolving style.
### Fixed
- Fixed player movement.
- Fixed player animations and animation speed.

## [0.0.0] - ~21/5/10 -> 21/6/5
- Pre-Changelog
