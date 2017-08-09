clear x

% initial conditions
x([1 2], 1) = [1 1];

% dynamics matrix per time step
A = [.98 0; 0 .975];

% linear dynamics
for t = 1:150-1
   x(:, t+1)  = A * x(:, t);    
end

% projection matrix
B = [1 0; 1 -.97];
y = B*x;
y = bsxfun(@rdivide, y, max(y,[],2));

% time binning (how many time steps in 100ms)
nt = 25;

close all
figure;
subplot(1,2,1);
plot([1:150]/nt, y')
axis tight
set(gca, 'ytick', [])
box off
xlabel('time')
xlim([0 150]/nt)

% dynamics matrix per 100ms of time
e = eig(A).^nt;

text(.5, .95, sprintf('eigenval1: %2.2f', e(1)), 'Units', 'normalized')
text(.5, .88, sprintf('eigenval2: %2.2f', e(2)), 'Units', 'normalized')

ylim([0 1.2])
title('Orange is diff of contractions')

%% same as before but different settings and B = I
clear x
x([1 2], 1) = [1 0];

A = [.985 -.02; .02 .98];
for t = 1:150-1
   x(:, t+1)  = A * x(:, t);    
end

B = eye(2);
y = B*x;
y = bsxfun(@rdivide, y, max(y,[],2));

subplot(1,2,2);
plot([1:150]/nt, y')
axis tight
box off
set(gca, 'ytick', [])
xlabel('time')
xlim([0 150]/nt)
ylim([-.2 1.3])
e = eig(A).^nt;

text(.2, .95, sprintf('eigenval1: %2.2f + %2.2fi', real(e(1)), imag(e(1))), 'Units', 'normalized')
text(.2, .88, sprintf('eigenval2: %2.2f + %2.2fi', real(e(2)), imag(e(2))), 'Units', 'normalized')

title('Orange is due to rotation')
