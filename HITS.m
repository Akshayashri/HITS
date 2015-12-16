% Hubs and authorities (HITS) algorithm script.
% (https://en.wikipedia.org/wiki/HITS_algorithm)
% Author: Tuomas Kynkaanniemi, 2015
close all
clear all;
% G(i,j) = 1, if page i has a link to page j
% Example:
%           [ 0 1 1; 
%      G  =   0 0 1; 
%             1 0 0 ];
% Page 1. (1. row) links to pages 2. and 3.
% Page #2 (2. row) has a link to page 3.
% Page #3 (3. row) has a link to page 1.

% Define threshold value, when to stop iterating:
t = 1E-3;

% Graph G of pages:
G = randi([0 1], 25, 25);

n = size(G, 2);
% Initial values for authority and hub scores of pages:
a = ones(n, 1) / sqrt(n); % Authority score
k = ones(n, 1) / sqrt(n); % Hub score

% Keep list of values for authority and hub scores during the iteration:
aValues = zeros(n, 0);
kValues = zeros(n, 0);
numIter = 0;

while 1
    % Old authority and hub scores:
    aOld = a; 
    kOld = k;
    % Update authority and hub scores and scale to unity:
    a = G' * kOld / sqrt(sum((G' * kOld).^2)); 
    k = G * aOld / sqrt(sum((G * aOld).^2));
    aDiff = abs(a - aOld);
    kDiff = abs(k - kOld);
    % Append new authority and hub scores to lists:
    aValues(:, end + 1) = a;
    kValues(:, end + 1) = k;
    if all(aDiff < t) && all(kDiff < t)
        break;
    end
   numIter = numIter + 1;
end

% Find the best authority and hub from pages:
[~, bestA] = max(a); % The page G(:, bestA) links to best hubs
[~, bestK] = max(k); % The page G(:, bestK) links to best authorities
