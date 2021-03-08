# A playground gem to immitate a space radar for space invaders

Space invaders and raddar expected in a .txt file. ASCII characters only.
You can check these [sample files](https://github.com/devtoro/space_radar/tree/master/spec/sample_files).

```ruby
require 'space_radar'
board = File.open('/Users/manolistsilikidis/Downloads/board_sample.txt')
in1 = File.open('/sample/file/dir/si1.txt')
in2 = File.open('/sample/file/dir/si2.txt')
in3 = File.open('/sample/file/dir/si3.txt')

invader1 = SpaceRadar::SpaceInvader.new in1
invader2 = SpaceRadar::SpaceInvader.new in2
invader3 = SpaceRadar::SpaceInvader.new in3

radar = SpaceRadar::Radar.new board, target: invader3
radar.init_lookout!

# If the target is found it is stored incide the radar instance, in the found_invaders attribute
found_invaders = radar.found_invaders

```

RSpec is used for testing.

```ruby
# To run all tests:
rspec spec/*_spec.rb
```
