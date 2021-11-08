def Hex(hex)
    return Gosu::Color.argb(hex[1,2].to_i(16),hex[3,4].to_i(16),hex[5,6].to_i(16),hex[7,8].to_i(16))
end