function [ mask ] = circleMask( cx, cy, r, iy, ix )
    [x,y]=meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy));
    mask=((x.^2+y.^2)<=r^2);
end

