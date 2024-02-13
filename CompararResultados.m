function [] = CompararResultados(x, y, z, net)
    output = sim(net, [x; y; z]);
    output = output';
    target = Interpolador(x, y, z);
    %Cálculo de error cuadrático medio 
    rmse = 0;
    for i = 1:size(output,2)
        rmse = rmse + (output(1, i) - target(1, i))^2;
    end
    rmse = sqrt(rmse/size(output,2));
    %Gráfico comparativo
    figure;hold on;
    plot(target(1,:), 'DisplayName', 'Función interpolada');
    plot(output(1,:), 'DisplayName', 'Función obtenida por la RNA');
    title(sprintf('(%g, %g, %g)',x,y,z));
    xlabel(['Error cuadrático medio: ', num2str(rmse)]);
    legend;
end