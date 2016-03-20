# Classes to represent a "Road System", with "Sections" of road between two "Points"
# and a "Path" from one "Point" to another "Point" consisting of a series of intermediate "Points".
# See the docs in the /doc folder that describe the problem and how the road system is described in
# the input data

class RoadSystem
  attr_reader :sections

  def add_section(section)
    (@sections ||= []).push section
  end
end

class Path
  attr_reader :total_time, :points

  def initialize(points = [], total_time = 0)
    @points = points
    @total_time = total_time
  end

  def add(label, distance)
    @points.push label
    @total_time += distance
  end

  def to_s
    points.join
  end
end

