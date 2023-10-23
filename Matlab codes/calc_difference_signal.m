function difference_sig = calc_difference_signal(sa, gear_mesh, num_sidebands)
% calc_difference_signal calculates the difference signal of the synchronous average
% Inputs:
%   sa - synchronous average
%   gear_mesh - gear mesh
%   num_sidebands - number of sidebands to remove
% Outputs:
%   difference_sig - the difference signal
% ----------------------------------------------------------------------- %

sa_len = length(sa) ; % synchronous average length
max_order = floor(sa_len/2) ; % maximum order


% find the oreder values to remove
orders_2_remove = [] ;
num_of_gear_mesh_harmonics = floor(max_order./gear_mesh) ;
for ii = 1:num_of_gear_mesh_harmonics
    gear_mesh_harmonic_order = gear_mesh*ii ;
    orders_2_remove = [orders_2_remove, (gear_mesh_harmonic_order-num_sidebands):(gear_mesh_harmonic_order+num_sidebands)] ; % each band includes the order of the ii-th GM and its sidebands from both sides.
end % of for
orders_2_remove(orders_2_remove > max_order) = [] ;
orders_2_remove_positive_inds = orders_2_remove + 1 ;
orders_2_remove_negative_inds = sa_len - orders_2_remove_positive_inds + 2 ;
orders_2_remove_inds = sort([orders_2_remove_positive_inds, orders_2_remove_negative_inds]) ;


% convert from cycle to order
sa_order = fft(sa,sa_len) ;


% set to zero the orders to remove
sa_order(orders_2_remove_inds) = 0 ;


% convert from order to cycle
difference_sig = real(ifft(sa_order, sa_len)) ;

end % of calc_difference_signal