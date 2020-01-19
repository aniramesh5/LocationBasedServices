function isKor = isKorollar(laplaceMatrix)
    % after fidler 2 if second eigenvalue > 0
    eigenvalues = eig(laplaceMatrix);

    isKor = eigenvalues(2) > 0-0.000000000000001;
end
