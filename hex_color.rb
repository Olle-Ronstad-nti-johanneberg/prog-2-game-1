def hex(hex2)
  Gosu::Color.argb(hex2[1, 2].to_i(16), hex2[3, 2].to_i(16), hex2[5, 2].to_i(16), hex2[7, 2].to_i(16))
end
