function extracted_bearing_tone = extract_specific_bearing_tone(dorder, ...
    bearing_sig_env_order, order_of_the_bearing_tone, order_sensativity)
% extract_specific_bearing_tone extractes a specific bearing tone of the
% envelope bearing signal in the order domain.
% Inputs:
%   dorder - order resolution
%   bearing_sig_env_order - bearing envelope signal in the order domain
%   order_of_the_bearing_tone - order value of the bearing tone
%   order_sensativity - sensitivity of the order value for searching the bearing tone pick
% Outputs:
%   extracted_bearing_tone - the extracted bearing tone value
% ----------------------------------------------------------------------- %

sig = abs(bearing_sig_env_order) ;

low_ind = floor((1-order_sensativity) * order_of_the_bearing_tone / dorder) ;
high_ind = ceil((1+order_sensativity) * order_of_the_bearing_tone / dorder) ;

extracted_bearing_tone = max(sig(low_ind:high_ind)) ;

end % of extract_specific_bearing_tone