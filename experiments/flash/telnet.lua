local s=net.createServer(net.TCP)
s:listen(2323,function(c)
   con_std = c
   function s_output(str)
      if(con_std~=nil)
         then con_std:send(str)
      end
   end
   node.output(s_output, 1)
   c:on("receive",function(c,l)
      node.input(l)
   end)
   c:on("disconnection",function(c)
      con_std = nil
      node.output(nil)
   end)
end)
