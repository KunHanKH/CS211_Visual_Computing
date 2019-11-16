function [K, R, t] = calibrate(pts3, pts2)
    
    N = size(pts3, 1);
    p = [pts3, ones(N, 1)];
    
    %% solve linear equations to get Calibration matrix
    A = zeros(N, 24);
    A(:, 5:8) = -p;
    A(:, 9:12) = p .* pts2(:, 2);
    A(:, 13:16) = p;
    A(:, 21:24) = -p .* pts2(:, 1);
    A = reshape(A', [12, 2 * N])';
    [U, S, V] = svd(A, 0);
    C = V(:, end);
    C = reshape(C', [4, 3])';
    C1 = C(:, 1:3);
    C2 = C(:, 4);
    t = inv(C1)* C2;
    [R, inK] = qr(inv(C1));
    K = inv(inK);
    K = K / K(end, end);
    D = diag(sign(diag(K)));
    K = K * D;
    R = D * R;
    t = D * t;
    
    t = det(R) * t;
    R = (det(R) * R)';
end