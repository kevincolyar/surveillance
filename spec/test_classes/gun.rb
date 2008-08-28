
class Gun

  #acts_as_watched :with => lambda {|msg| p msg} 

  def fire 
    puts 'fire'
  end

  def boom
    puts 'boom'
  end

  def shoot_bullet
    #Bullet.is_being_watched
    bullet = Bullet.new
    bullet.shoot
  end 
 
  def shoot(bullet_one, bullet_two, bullet_three, &block)
    puts "bullet_one: #{bullet_one}"
    puts "bullet_two: #{bullet_two}"
    puts "bullet_three: #{bullet_three}"
    puts "Block Given? #{block_given?}"
    block.call if block
  end

  PortsPerBlade = 20 

   def calculate_node_port(blade, port)
#ret = port > 0 ? (blade-1) * PortsPerBlade + port : 0
     return "stupid"
   end
end
