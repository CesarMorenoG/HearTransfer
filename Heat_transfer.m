
[ Coord,Order,Ex,Ey,Lx,Ly,Lcx,Lcy,A_e,A_geo,Q_gen,kx,ky ] = Data();
par=input('Do you wish to use parallel computing power?(Yes:1,No:0) ');
%%
[ Front_x1,Front_x2,Front_y1,Front_y2,T_x1,Q_x1,beta_x1,Tinf_x1,T_x2,Q_x2,beta_x2,Tinf_x2,T_y1,Q_y1,beta_y1,Tinf_y1,T_y2,Q_y2,beta_y2,Tinf_y2 ] = Boundary_conditions(Coord);
%%
if par==1
    [ T,K,Q ] = Elements_par( Coord,Order,Ex,Ey,Lx,Ly,Lcx,Lcy,Q_gen,kx,ky );
else
    [ T,K,Q ] = Elements( Coord,Order,Ex,Ey,Lx,Ly,Lcx,Lcy,Q_gen,kx,ky );
end
%%
[ T,K,Q ] = Boundaries( Coord,Order,Ex,Ey,Lx,Ly,Lcx,Lcy,A_geo,Front_x1,Front_x2,Front_y1,Front_y2,T_x1,Q_x1,beta_x1,Tinf_x1,T_x2,Q_x2,beta_x2,Tinf_x2,T_y1,Q_y1,beta_y1,Tinf_y1,T_y2,Q_y2,beta_y2,Tinf_y2,T,K,Q );
%%
[ MK,VQ ] = Assembly( Order,Ex,Ey,A_e,A_geo,K,Q  );
%%
[ Heat,Temperatura ] = Solve( Order,Ex,Ey,Lx,Ly,Lcx,Lcy,A_geo,Front_x1,Front_x2,Front_y1,Front_y2,T,MK,VQ );
clear T_x1 Q_x1 beta_x1 Tinf_x1 T_x2 Q_x2 beta_x2 Tinf_x2 T_y1 Q_y1 beta_y1 Tinf_y1 T_y2 Q_y2 beta_y2 Tinf_y2
%%
Graph( Order,Ex,Ey,Lx,Ly,Lcx,Lcy,Heat );
