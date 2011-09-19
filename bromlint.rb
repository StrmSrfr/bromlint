require 'fusefs'

class FNHFS # the fabulous non-hierarchical filesystem!
  def initialize()
    @guts = Hash.new
  end

  def contents(path)
    @guts.keys.collect do |name|
      name.sub(/^\//, '')
    end
  end

  def file?(path)
    @guts[path]
  end

  def read_file(path)
    @guts[path]
  end

  def can_write?(path) # a free-for-all!
    true
  end

  def write_to(path, str)
    @guts[path] = str
  end
end

$theModel = FNHFS.new

FuseFS.set_root( $theModel )

# Mount under a directory given on the command line.
FuseFS.mount_under ARGV.shift

FuseFS.run
