% ============================
% BASE DE CONOCIMIENTO
% ============================

% vehicle(Brand, Reference, Type, Price, Year).
vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(toyota, corolla, sedan, 24000, 2021).
vehicle(toyota, hilux, pickup, 35000, 2023).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(ford, escape, suv, 27000, 2022).
vehicle(ford, fiesta, sedan, 20000, 2020).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, serie3, sedan, 55000, 2023).
vehicle(bmw, m3, sport, 70000, 2022).
vehicle(nissan, frontier, pickup, 33000, 2022).
vehicle(nissan, sentra, sedan, 22000, 2021).
vehicle(chevrolet, silverado, pickup, 40000, 2023).
vehicle(chevrolet, equinox, suv, 26000, 2022).
vehicle(honda, civic, sedan, 23000, 2022).
vehicle(honda, crv, suv, 29000, 2023).
vehicle(hyundai, tucson, suv, 27000, 2021).
vehicle(hyundai, elantra, sedan, 21000, 2022).
vehicle(kia, sportage, suv, 25000, 2022).
vehicle(kia, rio, sedan, 19000, 2020).
vehicle(mercedes, glc, suv, 65000, 2023).
vehicle(mercedes, clasea, sedan, 48000, 2022).

% ============================
% FUNCIONALIDADES
% ============================

%----------FILTRAR POR PRESUPUESTO-----
% meet_budget(Referencia, PresupuestoMax)
meet_budget(Referencia, PresupuestoMax) :-
    vehicle(_, Referencia, _, Precio, _),
    Precio =< PresupuestoMax.

%----------FILTRAR POR REFERENCIAS POR MARCA--------
% referencias_por_marca(Marca, ListaReferencias)
referencias_por_marca(Marca, Referencias) :-
    findall(Ref, vehicle(Marca, Ref, _, _, _), Referencias).

%----------GENERAR REPORTE FILTRADO--------
% generate_report(Marca, Tipo, PresupuestoMax, resultado(Vehiculos, Total)).
generate_report(Marca, Tipo, PresupuestoMax, resultado(Vehiculos, Total)) :-
    findall((Marca, Ref, Tipo, Precio, Año),
        (vehicle(Marca, Ref, TipoVehiculo, Precio, Año),
         Precio =< PresupuestoMax,
         TipoVehiculo = Tipo),
        Vehiculos),
    calcular_total(Vehiculos, Total),
    Total =< 1000000.

% calcular_total(+ListaVehiculos, -TotalPrecio)
calcular_total([], 0).
calcular_total([(_, _, _, Precio, _)|T], Total) :-
    calcular_total(T, Resto),
    Total is Precio + Resto.

% ============================
% CASOS DE PRUEBA
% ============================

% Caso 1: Listar todas las referencias de Toyota SUV con precio < 30000
% ?- findall(Ref, (vehicle(toyota, Ref, suv, Precio, _), Precio < 30000), L).

% Caso 2: Mostrar vehículos Ford agrupados por tipo y año
% ?- bagof((Tipo, Año, Ref), vehicle(ford, Ref, Tipo, _, Año), Resultado).

% Caso 3: Calcular el valor total de un inventario de tipo "Sedan" con presupuesto máximo de 500000
% ?- findall((M, R, sedan, P, A), (vehicle(M, R, sedan, P, A), P =< 500000), L),
%    calcular_total(L, Total), Total =< 500000.
