class Optimal
  def self.calculate(system)
    best_paths = [Path.new, Path.new]

    system.sections.each do |section|
      apply(best_paths, section);
    end

    best_paths[0].total_time < best_paths[1].total_time ? best_paths[0] : best_paths[1]
  end

  def self.apply(paths, section)
    time_a = paths[0].total_time
    time_b = paths[1].total_time

    forward_time_to_a = time_a + section[0]
    cross_time_to_a = time_b + section[1] + section[2]
    forward_time_to_b = time_b + section[1]
    cross_time_to_b = time_a + section[0] + section[2]

    old_a = Path.new paths[0].points.clone, paths[0].total_time

    if forward_time_to_a <= cross_time_to_a
      # We take the "forward" direct path
      paths[0].add 'A', section[0]
    else
      # else we will take the route that crosses over
      paths[0] = Path.new paths[1].points.clone, paths[1].total_time
      paths[0].add 'B', section[1]
      paths[0].add 'C', section[2]
    end

    if forward_time_to_b <= cross_time_to_b
      # We take the "forward" direct path
      paths[1].add 'B', section[1]
    else
      # else we will take the route that crosses over
      paths[1] = old_a
      paths[1].add 'A', section[0]
      paths[1].add 'C', section[2]
    end
  end
end

