No he podido estar haciendo commits a cada cosa que hacía porque el portátil desde el que tengo el Sourcetree es muy lento para realizar los cálculos y he tenido que trabajar desde un ordenador más potente en casa. Tengo que mirar como utilizar el Sorcetree desde dos terminales.

Me he equivocado al hacer las anotaciones explicativas desde los commits, explicando en un script la explicación de otro.

Aquí adjunto las descripciones de cada script:

	Importallenergies.m: Script que importa todas las energías depositadas y fluencias 	de todas las energías

	PolynomialEnergyDeposited.mat: Tabla de los polinomios de energía depositada

	PolynomialFluence.mat: Tabla de los polinomios para fluencia
	
	PolynomialSingleEnergy.m: Función que calcula los polinomios para una energía 		dada. Adjunta las gráficas

	Range.m: Función que calcula el rango dada una energía depositada ne forma 		matricial (Z,R).

	Sigmapolynomial.m: Función que calcula los polinomios para un vector de energía y 	fluencia proporcionado por TOPAS. (Columnas de las matrices obtenidas en 		Importallenergies.m). El cálculo de la sigma para los últimos puntos del rango 		diverge. Hay que ver para cada energía dónde se trunca el cálculo de la sigma.

	tablepolinomia.m: Script que calcula las tablas de polinomios.

	Zinterp.m: Para una energía de las tabuladas se obtiene la distribución XY de 		energía depositada, fluencia y dosis en un plano Z

	Graficospolinomios.m: Representa los polinomios interpolados a todas las energías
	