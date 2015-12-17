%
% START OFF THE MIRROR CLASS
%
classdef Mirror
   properties
      x;
      y;
      number;
      deleted = 0;
      type;
   end
   methods
       
       function obj = Mirror(F)
         if nargin ~= 0
            m = size(F,1);
            n = size(F,2);
            obj(m,n) = Mirror;
            for i = 1:m
               for j = 1:n
                  obj(i,j).number = F(i,j);
               end
            end
         end
       end
      
      function obj = ini(counter)
        obj.x = 0;
        obj.y = 0;
        obj.number = counter;
        obj.deleted = 0;
      end
      
      function obj = update(obj, x, y, type)
        obj.x = x;
        obj.y = y;
        obj.type = type;
      end
      
      function [x, y, type, deleted] = getValues(obj)
          x = obj.x;
          y = obj.y;
          type = obj.type;
          deleted = obj.deleted;
      end
      
      function obj = updateDel(obj, option)
          obj.deleted = option;
      end
   end
end