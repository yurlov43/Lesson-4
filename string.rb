# frozen_string_literal: true

class String
  def in_black
    "\u001b[30m#{self}\u001b[0m"
  end

  def in_red
    "\u001b[31m#{self}\u001b[0m"
  end

  def in_green
    "\u001b[32m#{self}\u001b[0m"
  end

  def in_yellow
    "\u001b[33m#{self}\u001b[0m"
  end

  def in_blue
    "\u001b[34m#{self}\u001b[0m"
  end

  def in_magenta
    "\u001b[35m#{self}\u001b[0m"
  end

  def in_light_blue
    "\u001b[36m#{self}\u001b[0m"
  end

  def in_white
    "\u001b[37m#{self}\u001b[0m"
  end
end
