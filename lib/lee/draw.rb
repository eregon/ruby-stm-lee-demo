module Lee

  def self.draw(board, solutions, expansions=[], filename)
    require 'victor'

    if expansions.empty?
      solution_colours = %w(2E5266 DB2B39 FE9920 566E3D)
    else
      solution_colours = %w(4A4A4A 828282 8F8F8F 575757)
    end

    expansion_colours = %w(566E3D DB2B39)

    scale = 600.0 / board.width
    pad_radius = scale * 0.5
    line_width = scale * 0.5
    svg = Victor::SVG.new(width: board.width*scale, height: board.height*scale)

    expansions.zip(expansion_colours).each do |(expansion, solution), colour|
      expansion.each do |point|
        svg.rect x: point.x*scale,
                 y: point.y*scale,
                 width: scale,
                 height: scale,
                 stroke: 'none',
                 fill: "##{colour}",
                 opacity: 0.5
      end
    end

    solutions.each do |solution|
      colour = solution_colours[solution.hash % solution_colours.size]
      
      svg.polyline points: solution.map { |p| "#{p.x*scale + scale/2},#{p.y*scale + scale/2}"}.join(' '),
                   stroke: "##{colour}",
                   stroke_width: line_width,
                   fill: 'none'
    end

    expansions.each do |expansion, solution|
      svg.polyline points: solution.map { |p| "#{p.x*scale + scale/2},#{p.y*scale + scale/2}"}.join(' '),
                   stroke: 'black',
                   stroke_width: line_width*4,
                   fill: 'none'
    end
    
    board.pads.each do |pad|
      svg.circle cx: pad.x*scale + scale/2,
                 cy: pad.y*scale + scale/2,
                 r: pad_radius,
                 fill: 'black',
                 stroke: 'none'
    end
    
    svg.save filename
  end

end
