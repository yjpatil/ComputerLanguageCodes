function objOut = scale(objIn,x,y,z)%%scale(sph,L1/2, L1/2, L1/2)
%hierarchical scale function for structs and cell arrays

% Note: This function tries to change the shape of the input object (Sphere)
% Scale it to required dimensions
if (iscell(objIn)) %a list of structs
   for i=1:length(objIn)
      objOut{i}=objIn{i};
      V=objIn{i}.vertices;
      V=[V(:,1)*x, V(:,2)*y, V(:,3)*z];   % This is the point the scaling is performed!!
      objOut{i}.vertices=V;
   end      
 elseif (isstruct(objIn)) %must be a single struct   
    V=objIn.vertices;
    V=[V(:,1)*x, V(:,2)*y, V(:,3)*z];   % This is the point the scaling is performed!!
    objOut=objIn;
    objOut.vertices=V; 
 else
    error('input must be s struct or cell array')
 end %if   