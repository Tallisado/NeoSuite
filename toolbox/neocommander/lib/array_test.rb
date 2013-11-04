class A
	attr_accessor :number
	@number
	def initialize
		@number = 1
	end
	def hi
		puts "hi from a, im number: #{@number}"
	end
end

class B
	attr_accessor :number
	@number
	def initialize
		@number = 2
	end
	def hi
		puts self.class.name
		puts "hi from b, im number: #{@number}"
	end
end

a = A.new
b = B.new

c = Array.new
c.push(a)
c.push(b)

c.each do |item|
	item.hi()
	
	c[0].number = 5
	c[1].number = 5
end

c.each do |item|
	item.hi()
	c[1].number = 7
end