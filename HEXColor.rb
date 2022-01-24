def Hex(hex)
    return Gosu::Color.argb(hex[1,2].to_i(16),hex[3,2].to_i(16),hex[5,2].to_i(16),hex[7,2].to_i(16))
end