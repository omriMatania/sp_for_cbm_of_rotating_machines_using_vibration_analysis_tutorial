function [ftf, bsf, bpfo, bpfi] = calc_bearing_tones(shaft_speed, number_rolling_elements, ...
    rolling_element_diameter, pitch_diameter, bearing_contact_angle)
% calc_bearing_tones calculates the bearing tones, namely the fundamental train frequency (FTF), 
% ball-spin frequency (BSF), ball-pass frequency outer race (BPFO) and the ball-pass frequency inner race (BPFI), 
% corresponding to the optional cage fault, rolling element spall, outer race spall and inner race spall. 
% Inputs:
%   shaft_speed - shaft speed
%   number_rolling_elements - number of rolling elements
%   rolling_element_diameter - rolling element diameter
%   pitch_diameter - pitch diameter
%   bearing_contact_angle - bearing contact angle
% Outputs:
%   ftf - fundamental train frequency
%   bsf - ball-spin frequency
%   bpfo - ball-pass frequency outer race
%   bpfi - ball-pass frequency inner race
% ----------------------------------------------------------------------- %

coeff_1 = (shaft_speed / 2) ;
coeff_2 = (rolling_element_diameter / pitch_diameter) * cos(bearing_contact_angle) ;

ftf = coeff_1 * (1 - coeff_2) ;
bsf = (pitch_diameter / rolling_element_diameter) * coeff_1 * (1 - coeff_2^2) ;
bpfo = number_rolling_elements * coeff_1 * (1 - coeff_2) ;
bpfi = number_rolling_elements * coeff_1 * (1 + coeff_2) ;

end % of calc_bearing_tones

