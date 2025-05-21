USE ARCHAEOTOURS;

SELECT * FROM USUARIO;

SELECT * FROM LUGAR;

DELETE FROM USUARIO WHERE nombre = "Admin1";

DELETE FROM Usuario WHERE nombre = 'Lucía';

INSERT INTO Lugar (nombre, localizacion, tipologia, periodo, subperiodo, descripcion, imagen, link1, link2, link3, 
                    imagen_secundaria1, imagen_secundaria2, imagen_secundaria3, video1, video2) VALUES (NULL,"prueba",
                    "prueba","prueba","prueba","prueba",NULL, NULL, NULL, NULL, NULL, NULL, NULL, "prueba", "prueba");
                    
DELETE FROM LUGAR WHERE nombre = 'prueba';

DROP DATABASE ARCHAEOTOURS;

----------------------

CREATE DATABASE ARCHAEOTOURS;

USE ARCHAEOTOURS;

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    contraseña LONGTEXT NOT NULL,
    email VARCHAR(50) NOT NULL,
    tarjeta_credito VARCHAR(16),
    imagen LONGTEXT,
    tipo_usuario enum('Admin', 'Estandar')
);

CREATE TABLE Lugar (
    id_lugar INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    localizacion VARCHAR(100) NOT NULL,
    tipologia VARCHAR(50) NOT NULL,
    periodo VARCHAR(100) NOT NULL,
    subperiodo VARCHAR(100),
    descripcion LONGTEXT NOT NULL,
    imagen LONGTEXT,
    link1 LONGTEXT,
    link2 LONGTEXT,
    link3 LONGTEXT,
    imagen_secundaria1 LONGTEXT,
    imagen_secundaria2 LONGTEXT,
    imagen_secundaria3 LONGTEXT,
    video1 LONGTEXT,
    video2 LONGTEXT
);

CREATE TABLE Transaccion (
    id_transaccion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_transaccion DATE NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    cantidad_pagada DECIMAL(6, 2) NOT NULL,
    codigo_descuento VARCHAR(20)
);

CREATE TABLE Comentario (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    texto_comentario TEXT,
    valoracion INT CHECK (valoracion >= 0 AND valoracion <= 10),
    hora TIME NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE Guia (
    id_guia INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20),
    email VARCHAR(20) NOT NULL,
    especialidad VARCHAR(20)
);

CREATE TABLE Ruta (
    id_ruta INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT,
    valoracion INT CHECK (valoracion >= 0 AND valoracion <= 10),
    distancia INT CHECK (distancia >= 0 AND distancia <= 100),
    desnivel INT CHECK (desnivel >= 0 AND desnivel <= 10000)
);

CREATE TABLE Visita_Usuario_Lugar (
    id_usuario INT,
    id_lugar INT,
    PRIMARY KEY (id_usuario, id_lugar),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_lugar) REFERENCES Lugar(id_lugar) ON DELETE CASCADE
);

CREATE TABLE Tiene_Lugar_Comentario (
    id_lugar INT,
    id_comentario INT,
    PRIMARY KEY (id_lugar, id_comentario),
    FOREIGN KEY (id_lugar) REFERENCES Lugar(id_lugar) ON DELETE CASCADE,
    FOREIGN KEY (id_comentario) REFERENCES Comentario(id_comentario) ON DELETE CASCADE
);

CREATE TABLE Realiza_Usuario_Transaccion (
    id_usuario INT,
    id_transaccion INT,
    PRIMARY KEY (id_usuario, id_transaccion),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_transaccion) REFERENCES Transaccion(id_transaccion) ON DELETE CASCADE
);

CREATE TABLE Paga_Transaccion_Guia (
    id_transaccion INT,
    id_guia INT,
    PRIMARY KEY (id_transaccion),
    FOREIGN KEY (id_transaccion) REFERENCES Transaccion(id_transaccion) ON DELETE CASCADE,
    FOREIGN KEY (id_guia) REFERENCES Guia(id_guia) ON DELETE CASCADE
);

CREATE TABLE Escribe_Usuario_Comentario (
    id_comentario INT,
    id_usuario INT,
    PRIMARY KEY (id_comentario, id_usuario),
    FOREIGN KEY (id_comentario) REFERENCES Comentario(id_comentario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Contiene_Lugar_Ruta (
    id_lugar INT,
    id_ruta INT,
    PRIMARY KEY (id_lugar, id_ruta),
    FOREIGN KEY (id_lugar) REFERENCES Lugar(id_lugar) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES Ruta(id_ruta) ON DELETE CASCADE
);

INSERT INTO Usuario (id_usuario, nombre, apellido1, apellido2, contraseña, email, tarjeta_credito, imagen, tipo_usuario) VALUES
    (1, 'María', 'Martínez', 'Sánchez', 'Maria12345', 'maria_martinez@gmail.com', '9876543210987654', NULL, 'Estandar'),
    (2, 'Pedro', 'Díaz', 'García', 'Pedro12345', 'pedro_diaz@gmail.com', '6543210987654321', NULL, 'Estandar'),
    (3, 'Ana', 'González', 'Martínez', 'Ana12345', 'ana_gonzalez@gmail.com', '8765432109876543', NULL, 'Estandar'),
    (4, 'Carlos', 'Fernández', 'Pérez', 'Carlos12345', 'carlos_fernandez@gmail.com', '3456789012345678', NULL, 'Estandar'),
    (5, 'Laura', 'Rodríguez', 'Santos', 'Laura12345', 'laura_rodriguez@gmail.com', '5678901234567890', NULL, 'Estandar'),
    (6, 'Miguel', 'López', 'Gómez', 'Miguel12345', 'miguel_lopez@gmail.com', '4321098765432109', NULL, 'Estandar'),
    (7, 'Elena', 'Sánchez', 'Martín', 'Elena12345', 'elena_sanchez@gmail.com', '8901234567890123', NULL, 'Estandar'),
    (8, 'Javier', 'Pérez', 'González', 'Javier12345', 'javier_perez@gmail.com', '2109876543210987', NULL, 'Estandar'),
    (9, 'Isabel', 'Martín', 'Díaz', 'Isabel12345', 'isabel_martin@gmail.com', '7890123456789012', NULL, 'Estandar');

INSERT INTO Lugar (id_lugar, nombre, localizacion, tipologia, periodo, subperiodo, descripcion, imagen, link1, link2, link3, imagen_secundaria1, imagen_secundaria2, imagen_secundaria3, video1, video2) VALUES 
	(
    1,
    'El Rec Comtal',
    'Ciutat Vella, Sant Andreu, L''Eixample, Nou Barris, Sant Martí',
    'Canal de riego',
    'Época Medieval (803 d.C) – Época Contemporánea (Actualidad)',
    'Antigüedad tardía - Época Contemporánea',
    'A lo largo de diversas fuentes documentales e historiográficas se da por supuesto un origen romano del Rec Comtal. Relación normal, dada la coincidencia de trazado de las dos conducciones, el acueducto y el Rec. Este origen romano queda reflejado incluso en los informes que a finales del siglo XIX y principios del XX redactan la comunidad de regantes y el Ayuntamiento, por los litigios en torno a la propiedad y uso del agua. Es difícil, aún hoy en día, ubicar exactamente el inicio de la construcción del Rec Comtal. Hay varias hipótesis, la más extendida de las cuales nos dice que fue obra del conde Mir, el hermano pequeño del conde de Barcelona Borrell II, a principios de la segunda mitad del siglo X. Será a lo largo del siglo XI cuando el uso del Rec se generalice, especialmente a partir de la segunda mitad como queda reflejado en la documentación. Los molinos que se abastecen del Rec comienzan a proliferar, desde la zona de Sant Andreu, concretamente desde Finestrelles, hacia el Clot y dentro de la actual Ciutat Vella, en el entorno del monasterio de Sant Pere de les Puelles. Lo que sí queda claro es que no se pueden separar los procesos de la construcción del Rec, con la inutilización del acueducto romano, ya que no podemos hablar de desaparición de este. El Rec es protagonista de gran parte de los estudios. Son tres las fuentes básicas para emprender su estudio: las evidencias físicas -lo que queda o lo que se ha podido documentar en las intervenciones arqueológicas-, los documentos o escritos historiográficos, y, finalmente, las representaciones gráficas -tanto planimétricas como fotográficas-. La información que se extrae de cada una es diversa, pero al mismo tiempo complementaria, y ayuda a poder reconstruir parte de su trazado y su morfología. No conocemos cómo sería el primitivo Rec, dado que a lo largo del milenio de su existencia ha sufrido varias remodelaciones. Lo que se puede decir es que era un gran canal a cielo abierto, de una amplitud que variaba según el trazado. Los muros eran de sillares de piedra de Montjuïc, unidos con mortero de cal, con el fondo de tierra natural, sin ningún revestimiento especial. A lo largo del recorrido había puentes, la mayoría de piedra, pero también podría haber de madera, que facilitaban su cruce. Por la arqueología se ha podido documentar que el Rec se limpiaba con cierta regularidad, lo que hace que no se conserven materiales del primer momento de su construcción.
	Cabe señalar que donde se produjeron más cambios en relación a la forma y trazado del Rec, fue dentro de la ciudad, donde funcionó como una calle-canal, pasando a ser una estructura cubierta en parte, y a menudo con grandes puentes como el que se puede ver dentro del Born. Mención aparte es la gran remodelación que sufrió el Rec a raíz de la construcción de la Ciutadella, que comportó un cambio importante tanto del Rec como de su desembocadura al mar.',
    '../view/img/rec_comtal.jpg',
    'http://cartaarqueologica.bcn.cat/3426',
    'https://es.wikipedia.org/wiki/Acequia_Condal',
    'https://barcelonasecreta.com/rec-comtal-proyecto-recuperacion/',
    '../view/img/rec_comtal1.jpg',
    '../view/img/rec_comtal2.jpg',
    '../view/img/rec_comtal3.jpg',
    'https://www.youtube.com/embed/YL_8jPe9bz8',
    'https://www.youtube.com/embed/1aIN85V5Tik'),
    (
    2,
    'El Born',
    'Ciutat Vella',
    'Zona urbana',
    'Época Medieval (1359 d.C) – Época Contemporánea (1860 d.C)',
    'Época Alto Medieval - Época Contemporánea',
    'Esta intervención llevada a cabo en el Mercado del Born era consecuencia directa del proyecto de musealización y construcción de un Centro Cultural en el antiguo Mercado del Born. Dicho proyecto, a su vez, derivaba de la intervención realizada en los años 2000-2001, durante la cual se descubrió una parte del barrio de la Ribera del siglo XVIII, cuyo grado de conservación era tan excepcional que el Ayuntamiento de Barcelona inició un proceso de protección de los restos y diseño museístico. El Servicio de Arqueología Urbana del Museo de Historia de la Ciudad, a través de sus técnicos arqueólogos, diseñó un proyecto en el que se establecía una intervención arqueológica preventiva, según la normativa municipal y la legislación vigente. En este proyecto se identificaron 22 puntos de actuación, previos al inicio de la construcción del Centro Cultural. Los puntos respondían a lugares que podrían verse afectados por el desarrollo de las obras en el interior del antiguo mercado del Born y por la construcción del nuevo equipamiento cultural. El propósito de la intervención era preservar los restos y evaluar las perspectivas arqueológicas que ofrecía el subsuelo de los tramos no excavados. Finalmente, en el año 2007 se intervino frente al número 5 de la calle Comercial, debido a las obras de conexión entre el Mercado del Born y el edificio anexo, donde se excavó una extensión de 80 m² hasta agotar la estratigrafía. De esta manera, las acciones realizadas en el Mercado del Born durante esta intervención se clasificaron en diferentes apartados. En primer lugar, seguimientos y controles arqueológicos, tanto dentro como fuera del antiguo mercado y realizados previamente a la excavación de los puntos propuestos por los técnicos del Museo. También se excavaron 37 puntos de actuación arqueológica: 22 del proyecto original más los 15 del proyecto ampliado y la excavación de cinco puntos de actuación específicos que respondían a trabajos inconclusos de la intervención del año 2001. El diseño de los puntos de intervención arqueológica respondía a diferentes motivos técnicos: ampliación del conocimiento de ciertas zonas documentadas en la intervención de 2000-2001; excavación de puntos por motivos técnicos, por motivos de saneamiento de la obra; excavación para poder restaurar y consolidar ciertos restos y, por último, desmontaje de algunas estructuras posteriores a 1716 para tener una visión más esclarecedora de los procesos constructivos. Por otro lado, se procedió al cubrimiento con gravilla, por necesidades museísticas, de diferentes puntos del yacimiento.',
    '../view/img/born.jpg',
    'http://cartaarqueologica.bcn.cat/339',
    'https://ca.wikipedia.org/wiki/Mercat_del_Born',
    'https://elbornculturaimemoria.barcelona.cat/es/explora/el-conjunto-arqueologico/',
    '../view/img/born1.jpg',
    '../view/img/born2.jpg',
    '../view/img/born3.jpg',
    'https://www.youtube.com/embed/gZs2soBO5jA',
    'https://www.youtube.com/embed/eqUITlNDVVU'),
	(
    3,
    'Vía Sepulcral de la Plaza de la Vil·la de Madrid',
    'Ciutat Vella',
    'Necrópolis Romana',
    'Época Antigua (10 a.C) - Época Antigua (299 d.C)',
    'Roma Imperial - Roma imperial',
    'Época prehistórica (neolítico antiguo) BETA 5535 a 5460 cal B.C. De este período se localizó una estructura funeraria de planta circular. Presentaba en su interior una serie de losas de calcárea dispuestas alrededor del inhumado formando una caja o cista. De esta inhumación solo se conservaba parte del esqueleto postcraneal. Junto con el inhumado se documentaron restos líticos que estarían relacionados con la indumentaria del individuo. Época romana (siglos I-V d.C.). Con la fundación de la colonia de Barcino, se estructuró también todo el territorio alrededor de la ciudad. Se crearon vías, probablemente reutilizando antiguos caminos, de entrada y salida de la ciudad. Una de estas era la que salía de la puerta decumana y se dirigía hacia el noroeste, y discurría por el lugar de la actual plaza Vila de Madrid. Al encontrarse esta vía situada en el suburbium inmediato de la ciudad, se usó como vía sepulcral, es decir, se utilizaron sus márgenes como espacio funerario. Este hecho ya quedó claramente documentado con las excavaciones de los años 1954 y 1956/57. La intervención del 2000-2003 permitió conocer la ordenación del resto del lugar en estos siglos, estableciendo una evolución cronológica y funcional. Así, del siglo I d.C., se localizó una sitja o pozo, recortado en el suelo geológico, en el extremo meridional del trazado del antiguo callejón de la Mare de Déu. El relleno de esta estructura (5 cánidos en conexión anatómica, 1 cráneo de équido) llevó a los arqueólogos a darle un carácter o función ritual (posiblemente asociado al mundo funerario y a la vía sepulcral que se encuentra a pocos metros hacia el oeste). De los siglos II-III d.C., en el extremo meridional del trazado del antiguo callejón de la Mare de Déu, se pudo documentar un ámbito funerario de época romana (datable entre mediados del siglo II y mediados del siglo III d.C.). Se trataba de un espacio longitudinal de unos 8,85 m de longitud y unos 5 m de ancho. Quedaba delimitado, por el sur, por un muro de cierre y hacia el este, por un recorte hecho en el sustrato geológico. Este espacio no se pudo delimitar ni por la parte norte ni por el oeste. En su interior se localizaron numerosos enterramientos que determinaban la presencia, al menos, de unos 66 individuos. Estos enterramientos fueron realizados utilizando dos tipos de ritual, el de la incineración (7 individuos) y el de la inhumación (47 individuos). Todos estos enterramientos presentaban diversas tipologías de tumbas (incineración en urna, dentro de una tumba de tegulae y en caja de madera) (inhumaciones en fosa simple, en fosa enmarcada por piedras, en tumba de tegulae, dentro de una ánfora y en tumba con forma de copa). Algunas de estas tumbas iban asociadas con ofrendas de diversas tipologías y sin apenas ajuar. También fue posible documentar elementos que acompañaban seguramente a los rituales que rodeaban la muerte (banquetes funerarios). Por la importancia del hecho, cabe destacar el hallazgo en el sector sur de este espacio de una tumba del tipo copa de planta rectangular y construida con obra de albañilería que presentaba un revestimiento exterior de color rojo. Entre el material móvil que se recuperó relacionado con la copa apareció una placa de mármol con una inscripción de temática funeraria. También se documentó la parte inferior de un ara funeraria, hecha con gres de Montjuïc, asociada a unos niveles de cenizas y carbones y con una especie de objeto de madera. Por otro lado, también cabe destacar el hallazgo en el sector noreste del ámbito funerario de una pequeña estructura de forma rectangular y con los ángulos redondeados, formada por arcilla quemada y endurecida. Se interpretó como un posible ustrinium. Se situó la fecha de abandono de este espacio funerario a mediados del siglo III d.C. (post quem), en un período en el que se han constatado crecidas de algún arroyo, seguramente el que discurría por la actual zona de las Ramblas. Por otro lado, en los límites orientales de esta estructura funeraria se localizaron tres enterramientos más.',
    '../view/img/via_sepulcral_madrid.jpg',
    'http://cartaarqueologica.bcn.cat/94',
    'https://es.wikipedia.org/wiki/Vía_sepulcral_de_la_plaza_de_la_Villa_de_Madrid',
    'https://www.barcelona.cat/museuhistoria/es/patrimonios/los-espacios-del-muhba/muhba-sepulcral-romana',
    '../view/img/via_sepulcral_madrid1.jpg',
    '../view/img/via_sepulcral_madrid2.jpg',
    '../view/img/via_sepulcral_madrid3.jpg',
    'https://www.youtube.com/embed/L3kB4xqt1Uc',
    'https://www.youtube.com/embed/Lhwigj0Mwf4'),
	(
    4,
    'Conjunto Monumental de la Plaça del Rei',
    'Ciutat Vella',
    'Complejo Urbano',
    'Época Antiga (10 a.C) – Época Antiga (715 d.C)',
    'Roma Imperial - Antiguitat tardana',
    'La plaza actual, junto con el terreno donde hoy se encuentra el palacio del Lugarteniente, formaban parte del patio del palacio real. Aunque estaba cerrado por una muralla, era un espacio abierto al pueblo, utilizado durante siglos como mercado. A lo largo del tiempo, la plaza ha tenido diferentes usos y en 1387, durante el reinado de Juan I, tuvo lugar la primera corrida de toros en Barcelona, según consta de manera oficial en el Archivo General de la Corona de Aragón. El 7 de diciembre de 1492, en las escaleras de entrada del Palacio Real Mayor, el rey Fernando II de Aragón sufrió un intento de asesinato por parte de Joan de Canyamars, siendo posteriormente juzgado y condenado a muerte. La disposición rectangular actual de la plaza se atribuye a un proyecto de urbanización realizado en la segunda mitad del siglo XIV, durante el reinado de Martín I, desplazando el mercado para crear un espacio adecuado para la celebración de justas. A mediados del siglo XIX, el Ayuntamiento de Barcelona encargó al arquitecto municipal Francisco Daniel Molina la reforma de la plaza, que sufría el deterioro de los edificios circundantes, que habían perdido su uso noble. Molina construyó una fuente monumental de estilo neogótico, inaugurada el 16 de octubre de 1853. Entre la fuente y la capilla de Santa Ágata se colocó una columna, reconstruida con los restos de otras dos del antiguo Templo de Augusto, descubiertas tras el derribo de una casa en la calle Llibreteria. Entre 1931 y 1934 se realizó una nueva reforma a cargo de Agustín Durán Sanpere, que le dio a la plaza, en gran medida, su aspecto actual. Se eliminaron los árboles y la fuente neogótica de Molina. En esta misma época se trasladó aquí la Casa Padellàs, originalmente ubicada en un tramo de la calle Mercaders derribado para abrir la Vía Layetana. Como resultado de esta reconstrucción, se descubrieron importantes restos de la ciudad romana en el subsuelo de la plaza. Este hallazgo condujo a la creación del Museo de Historia de Barcelona (MHCB), promovido por Duran i Sanpere e instalado en la Casa Padellàs desde 1943. En 1956, la columna romana fue trasladada a la sede del Centro Excursionista de Cataluña, donde se conservan otros restos del Templo de Augusto. En 1986, se instaló en la plaza la escultura "Topos V", una obra de acero fundido de Eduardo Chillida.',
    '../view/img/plaça_rei.jpg',
    'http://cartaarqueologica.bcn.cat/833',
    'https://es.wikipedia.org/wiki/Museo_de_Historia_de_Barcelona',
    'https://www.barcelona.cat/museuhistoria/es/patrimonios/los-espacios-del-muhba/muhba-placa-de-rei',
    '../view/img/plaça_rei1.jpg',
    '../view/img/plaça_rei2.jpg',
    '../view/img/plaça_rei3.jpg',
    'https://www.youtube.com/embed/0ftBTAKXvww',
    'https://www.youtube.com/embed/St8MXCkI6rU'),
	(
    5,
    'Drassanes Reials de Barcelona',
    'Ciutat Vella',
    'Fábrica de barcos (Atarazanas)',
    'Medieval (1150 d.C) - Contemporani (1953 d.C)',
    'Alto Medieval - Contemporani',
    'La actuación de las naves de levante permitió documentar la presencia de algunas estructuras que suponían la continuidad de aquellas descubiertas en las naves de poniente y ha puesto de relieve algunas ausencias que obligan a replantear el alcance de las reformas y de los diferentes proyectos constructivos. En este sentido, el estudio arqueológico del edificio de la atarazana corrobora lo que ya se sospechaba: la inmensa parte del edificio que vemos actualmente no es de época gótica, aunque el patrón constructivo y el estilo supongan una clara continuidad del diseño proyectado en época medieval. La fase más antigua de la atarazana documentada aquí responde al perímetro porticado este, con una serie de "tiendas", que aún se mantienen en pie gracias a las actuaciones más o menos respetuosas llevadas a cabo a lo largo del tiempo. Relacionado con esta fase de Pedro el Grande (1276-1285) se ha podido estudiar el acceso original de la atarazana por el lado de levante y parte de su pórtico, y se ha localizado la continuación del muro de cierre norte o de montaña, estudiado ya en la campaña de las naves de poniente. De una segunda fase, posiblemente de la época de Pedro III el Ceremonioso (1336-1387), aún quedan en pie los dos primeros tramos de naves paralelas al paseo de Josep Carner. Estos tramos suponen la primera fase de cubrimiento en este sector de la atarazana, dejando una amplia zona de patio, al contrario que en las naves de poniente, donde Nadal y Vilardell pudieron documentar una fase de cubierta previa de la primera mitad del siglo XIV (en época de Alfonso III, el Benigno). En este momento se iniciará la edificación de una serie de naves soberanas o de montaña con la voluntad de hacer un cuerpo idéntico al marítimo con un gran patio en medio. Esta fase constructiva nunca se acabará, probablemente por falta de financiación. Posteriormente, y para eliminar gran parte del patio descubierto que funcionaba hasta ese momento, se edificó una tercera fase constructiva ubicada cronológicamente en el siglo XV, que rompió con el modelo anterior y supuso la creación de un estrecho pasadizo en sentido este-oeste que separaba estos nuevos tramos de las precedentes. La última fase constructiva documentada, iniciada a mediados del siglo XVI, supuso el retroceso de la línea de fachada del lado de mar que venía funcionando desde el siglo XIII y la creación de nuevos tramos en dirección montaña para substituir aquellas desaparecidas en el lado de mar. Parece que este desplazamiento del edificio vino motivado por la construcción del muelle del puerto en 1477, hecho que provocó la modificación de las corrientes marinas, que ahora erosionaban de manera drástica el litoral frente a las atarazanas. En relación a estas nuevas naves de montaña que se prolongaron en dirección al mar hasta sustituir las de época medieval (a excepción de los dos tramos conservados de Pedro el Ceremonioso), si bien el estudio del edificio desde el punto de vista arquitectónico ofrecía un discurso que defendía, de manera lógica, la terminación de estas en la segunda mitad del siglo XVI, la excavación arqueológica sistemática del subsuelo ha permitido rechazar estas cronologías, variándolas un siglo. En efecto, la intervención en la mitad sur de la nave de levante ha documentado que el proyecto no llegó a culminarse en el siglo XVI, ya que una serie de ambientes que estaban previstos en la primera propuesta de edificación, se empezaron a utilizar durante el siglo XVII.',
    '../view/img/drassanes.jpg',
    'http://cartaarqueologica.bcn.cat/577',
    'https://es.wikipedia.org/wiki/Atarazanas_Reales_de_Barcelona',
    'https://www.barcelona.cat/museuhistoria/es/patrimonios/los-espacios-del-muhba/muhba-atarazanas',
    '../view/img/drassanes1.jpg',
    '../view/img/drassanes2.jpg',
    '../view/img/drassanes3.jpg',
    'https://www.youtube.com/embed/0nkMyb_0PyM',
    'https://www.youtube.com/embed/94t0nZfmgEw'),
    (
    6,
    'Parque Güell',
    'Gracia',
    'Parque',
    'Época Contemporánea (1900 d.C - 1914 d.C)',
    'Modernismo',
    'El Parque Güell es una obra arquitectónica de Antoni Gaudí, construida entre 1900 y 1914. Originalmente concebido como un proyecto de urbanización residencial, se transformó en un parque público. El diseño del parque se caracteriza por la integración de la arquitectura con el entorno natural, con formas orgánicas y coloridas cerámicas. Es un ejemplo destacado del modernismo catalán y un símbolo de Barcelona.',
    '../view/img/parque_guell.jpg',
    'https://es.wikipedia.org/wiki/Parque_Güell',
    'https://www.barcelona.cat/es/que-hacer-en-barcelona/parques-y-jardines/parc-guell_92086010168.html',
    'https://www.parkguell.cat/es/',
    '../view/img/parque_guell1.jpg',
    '../view/img/parque_guell2.jpg',
    '../view/img/parque_guell3.jpg',
    'https://www.youtube.com/embed/ZQOeE6ZZkcQ',
    'https://www.youtube.com/embed/7Ka0SCe-MkU'),
    (
    7,
    'La Pedrera (Casa Milà)',
    'Eixample',
    'Edificio residencial',
    'Época Contemporánea (1906 d.C - 1912 d.C)',
    'Modernismo',
    'La Pedrera, también conocida como Casa Milà, es un edificio modernista diseñado por Antoni Gaudí. Construido entre 1906 y 1912, es famoso por su fachada ondulada y su innovador uso del hierro forjado. Es uno de los edificios más emblemáticos de Barcelona y fue declarado Patrimonio de la Humanidad por la UNESCO.',
    '../view/img/la_pedrera.jpg',
    'https://es.wikipedia.org/wiki/Casa_Mil%C3%A0',
    'https://www.lapedrera.com/es/home',
    'https://www.casabatllo.es/la-pedrera/',
    '../view/img/la_pedrera1.jpg',
    '../view/img/la_pedrera2.jpg',
    '../view/img/la_pedrera3.jpg',
    'https://www.youtube.com/embed/x0XB9e5ZhXE',
    'https://www.youtube.com/embed/kRp8mnmjOdU'),
    (
    8,
    'Sagrada Familia',
    'Eixample',
    'Basílica',
    'Época Contemporánea (1882 d.C - Actualidad)',
    'Modernismo',
    'La Sagrada Familia es una basílica católica diseñada por Antoni Gaudí. Su construcción comenzó en 1882 y aún está en curso. Es uno de los ejemplos más famosos del modernismo catalán y presenta una combinación única de arquitectura gótica y formas modernistas. La basílica es Patrimonio de la Humanidad y una de las atracciones más visitadas de Barcelona.',
    '../view/img/sagrada_familia.jpg',
    'https://es.wikipedia.org/wiki/Sagrada_Familia',
    'https://sagradafamilia.org/',
    'https://www.barcelona.com/es/guia_ciudad/monumentos/sagrada_familia',
    '../view/img/sagrada_familia1.jpg',
    '../view/img/sagrada_familia2.jpg',
    '../view/img/sagrada_familia3.jpg',
    'https://www.youtube.com/embed/2ZrBC45OWfU',
    'https://www.youtube.com/embed/Lvj9l7w9hNU'),
    (
    9,
    'Montjuïc',
    'Sants-Montjuïc',
    'Colina',
    'Época Antigua (siglo III a.C) - Época Contemporánea',
    'Antigüedad tardía - Época Contemporánea',
    'Montjuïc es una colina en Barcelona que ha sido testigo de importantes eventos a lo largo de la historia. En la antigüedad, se utilizaba como lugar de enterramiento. En épocas más recientes, ha albergado exposiciones internacionales y eventos deportivos, incluyendo los Juegos Olímpicos de 1992. La colina es conocida por sus jardines, el castillo de Montjuïc y numerosas instalaciones culturales.',
    '../view/img/montjuic.jpg',
    'https://es.wikipedia.org/wiki/Montjuic',
    'https://www.barcelona.cat/es/conocebcn/pics/montjuic',
    'https://www.barcelonaturisme.com/wv3/es/page/1018-montjuic.html',
    '../view/img/montjuic1.jpg',
    '../view/img/montjuic2.jpg',
    '../view/img/montjuic3.jpg',
    'https://www.youtube.com/embed/6S0EHDjBGM8',
    'https://www.youtube.com/embed/nzJrMJuWEmY'),
    (
    10,
    'Castillo de Montjuïc',
    'Sants-Montjuïc',
    'Fortaleza',
    'Época Moderna (1640 d.C) - Época Contemporánea',
    'Barroco - Contemporáneo',
    'El Castillo de Montjuïc es una antigua fortaleza militar situada en la colina de Montjuïc. Construido en 1640 y ampliado en el siglo XVIII, ha tenido un papel importante en la historia militar de Barcelona. Hoy en día, el castillo alberga un museo militar y ofrece vistas panorámicas de la ciudad y el puerto.',
    '../view/img/castillo_montjuic.jpg',
    'https://es.wikipedia.org/wiki/Castillo_de_Montjuic',
    'https://ajuntament.barcelona.cat/es/equipamientos/castillo-de-montjuic',
    'https://www.barcelona.com/es/guia_ciudad/atracciones/castillo_de_montjuic',
    '../view/img/castillo_montjuic1.jpg',
    '../view/img/castillo_montjuic2.jpg',
    '../view/img/castillo_montjuic3.jpg',
    'https://www.youtube.com/embed/B4qQ8ZPzG8U',
    'https://www.youtube.com/embed/B8X2XhUJQqE'),
    (
    11,
    'Palau de la Música Catalana',
    'Sant Pere, Santa Caterina i la Ribera',
    'Sala de conciertos',
    'Época Contemporánea (1905 d.C - 1908 d.C)',
    'Modernismo',
    'El Palau de la Música Catalana es una sala de conciertos en Barcelona diseñada por el arquitecto Lluís Domènech i Montaner. Construido entre 1905 y 1908, es uno de los principales exponentes del modernismo catalán. El edificio destaca por su decoración colorida y detallada, y ha sido declarado Patrimonio de la Humanidad por la UNESCO.',
    '../view/img/palau_musica.jpg',
    'https://es.wikipedia.org/wiki/Palau_de_la_M%C3%BAsica_Catalana',
    'https://www.palaumusica.cat/',
    'https://www.barcelona.com/es/guia_ciudad/monumentos/palau_de_la_musica_catalana',
    '../view/img/palau_musica1.jpg',
    '../view/img/palau_musica2.jpg',
    '../view/img/palau_musica3.jpg',
    'https://www.youtube.com/embed/xpMeSa1M2Y0',
    'https://www.youtube.com/embed/oCwU6WvopRc'),
    (
    12,
    'Hospital de la Santa Creu i Sant Pau',
    'El Guinardó',
    'Complejo hospitalario',
    'Época Contemporánea (1902 d.C - 1930 d.C)',
    'Modernismo',
    'El Hospital de la Santa Creu i Sant Pau es un conjunto modernista diseñado por Lluís Domènech i Montaner. Construido entre 1902 y 1930, es uno de los hospitales más grandes y emblemáticos de Barcelona. El complejo destaca por su arquitectura modernista y ha sido declarado Patrimonio de la Humanidad por la UNESCO.',
    '../view/img/hospital_sant_pau.jpg',
    'https://es.wikipedia.org/wiki/Hospital_de_la_Santa_Creu_i_Sant_Pau',
    'https://www.santpaubarcelona.org/',
    'https://www.barcelona.com/es/guia_ciudad/monumentos/hospital_de_la_santa_creu_i_sant_pau',
    '../view/img/hospital_sant_pau1.jpg',
    '../view/img/hospital_sant_pau2.jpg',
    '../view/img/hospital_sant_pau3.jpg',
    'https://www.youtube.com/embed/C6B_MWCN7Kc',
    'https://www.youtube.com/embed/Q5SIkfIToOc'),
    (
     13,
    'Casa Batlló',
    'Eixample',
    'Edificio residencial',
    'Época Contemporánea (1904 d.C - 1906 d.C)',
    'Modernismo',
    'La Casa Batlló es una obra maestra del modernismo catalán diseñada por Antoni Gaudí. Construida entre 1904 y 1906, destaca por su fachada ondulante y su decoración con azulejos de colores. El interior es igualmente impresionante, con formas orgánicas y una atención meticulosa al detalle. Es Patrimonio de la Humanidad por la UNESCO y una de las atracciones más visitadas de Barcelona.',
    '../view/img/casa_batllo.jpg',
    'https://es.wikipedia.org/wiki/Casa_Batll%C3%B3',
    'https://www.casabatllo.es/',
    'https://www.barcelona.com/es/guia_ciudad/monumentos/casa_batllo',
    '../view/img/casa_batllo1.jpg',
    '../view/img/casa_batllo2.jpg',
    '../view/img/casa_batllo3.jpg',
    'https://www.youtube.com/embed/3QV0mMhlp8Y',
    'https://www.youtube.com/embed/hmCbYjYdlG0'),
    (
    14,
    'Parque de la Ciudadela',
    'Ciutat Vella',
    'Parque',
    'Época Contemporánea (1872 d.C - 1888 d.C)',
    'Modernismo',
    'El Parque de la Ciudadela es un parque público situado en el corazón de Barcelona. Inaugurado en 1888 para la Exposición Universal, el parque alberga numerosos edificios históricos, museos y el zoológico de Barcelona. Es un espacio verde popular para los residentes y turistas, y cuenta con el famoso "Mamuth" y la Cascada Monumental.',
    '../view/img/parque_ciudadela.jpg',
    'https://es.wikipedia.org/wiki/Parque_de_la_Ciudadela',
    'https://www.barcelona.cat/es/conocebcn/pics/parque-de-la-ciudadela',
    'https://www.barcelonaturisme.com/wv3/es/page/3912-parque-de-la-ciudadela.html',
    '../view/img/parque_ciudadela1.jpg',
    '../view/img/parque_ciudadela2.jpg',
    '../view/img/parque_ciudadela3.jpg',
    'https://www.youtube.com/embed/wDeZ13Mm4XI',
    'https://www.youtube.com/embed/yUu1sdslCmI'),
    (
    15,
    'Templo Expiatorio del Sagrado Corazón',
    'Tibidabo',
    'Iglesia',
    'Época Contemporánea (1902 d.C - 1961 d.C)',
    'Neogótico',
    'El Templo Expiatorio del Sagrado Corazón es una iglesia neogótica situada en la cima del Tibidabo, la montaña más alta de Barcelona. Construido entre 1902 y 1961, ofrece vistas panorámicas de la ciudad y el mar Mediterráneo. Es un lugar de peregrinación y un hito visible desde gran parte de Barcelona.',
    '../view/img/templo_tibidabo.jpg',
    'https://es.wikipedia.org/wiki/Templo_Expiatorio_del_Sagrado_Corazón_(Barcelona)',
    'https://www.tibidabo.cat/es/el-templo-del-sagrado-corazon',
    'https://www.barcelonaturisme.com/wv3/es/page/4172-templo-del-sagrado-corazon.html',
    '../view/img/templo_tibidabo1.jpg',
    '../view/img/templo_tibidabo2.jpg',
    '../view/img/templo_tibidabo3.jpg',
    'https://www.youtube.com/embed/r3ddtrmAoV4',
    'https://www.youtube.com/embed/Z8G8TgfqZoA'
);

INSERT INTO Transaccion (id_transaccion, fecha_transaccion, metodo_pago, cantidad_pagada, codigo_descuento) VALUES
    (1, '2024-01-26', 'Tarjeta de crédito', 50.00, 'DESC50'),
    (2, '2024-01-27', 'PayPal', 30.00, NULL),
    (3, '2024-01-28', 'Tarjeta de débito', 75.00, 'SUMMER25'),
    (4, '2024-01-29', 'Transferencia bancaria', 40.00, NULL),
    (5, '2024-01-30', 'Tarjeta de crédito', 60.00, NULL),
    (6, '2024-02-01', 'PayPal', 25.00, 'NEWUSER10'),
    (7, '2024-02-02', 'Tarjeta de débito', 90.00, NULL),
    (8, '2024-02-03', 'Transferencia bancaria', 55.00, 'FRIENDS20'),
    (9, '2024-02-04', 'Tarjeta de crédito', 70.00, NULL),
    (10, '2024-02-05', 'PayPal', 45.00, NULL);

INSERT INTO Comentario (id_comentario, texto_comentario, valoracion, hora, fecha) VALUES
    (1, '¡Excelente tour! Muy informativo.', 9, '12:30:00', '2024-01-26'),
    (2, 'El guía era muy amable, pero la ruta podría mejorar.', 7, '15:45:00', '2024-01-27'),
    (3, 'Increíble experiencia, definitivamente lo recomendaría.', 10, '10:00:00', '2024-01-28'),
    (4, 'El lugar es hermoso, pero el clima no ayudó mucho.', 8, '14:20:00', '2024-01-29'),
    (5, 'El guía conocía muy bien la historia, fue fascinante.', 9, '11:45:00', '2024-01-30'),
    (6, 'Buena relación calidad-precio, disfrutamos mucho.', 8, '16:30:00', '2024-02-01'),
    (7, 'El recorrido fue un poco corto para mi gusto.', 6, '13:10:00', '2024-02-02'),
    (8, 'Gran atención al cliente, resolveram todos nuestros problemas.', 10, '09:20:00', '2024-02-03'),
    (9, 'El sitio histórico es impresionante, no dudaría en volver.', 9, '12:00:00', '2024-02-04'),
    (10, 'Una maravillosa experiencia, en un lugar que transmite mucha historia', 8, '16:15:00', '2024-02-04');
    
INSERT INTO Guia (id_guia, nombre, apellido1, apellido2, email, especialidad) VALUES
    (1, 'Carlos', 'Fernández', 'García', 'carlos@email.com', 'Historia'),
    (2, 'Laura', 'Rodríguez', 'Pérez', 'laura@email.com', 'Arqueología'),
    (3, 'Javier', 'Gómez', 'López', 'javier@email.com', 'Arquitectura'),
    (4, 'Ana', 'Martínez', 'Sánchez', 'ana@email.com', 'Arte'),
    (5, 'Miguel', 'Santos', 'Pérez', 'miguel@email.com', 'Naturaleza'),
    (6, 'Elena', 'Díaz', 'González', 'elena@email.com', 'Cultura'),
    (7, 'Pablo', 'López', 'Fernández', 'pablo@email.com', 'Historia'),
    (8, 'Isabel', 'Pérez', 'Martín', 'isabel@email.com', 'Arqueología'),
    (9, 'Sara', 'García', 'Rodríguez', 'sara@email.com', 'Arte'),
    (10, 'Daniel', 'Martín', 'Gómez', 'daniel@email.com', 'Naturaleza');

INSERT INTO Ruta (id_ruta, descripcion, valoracion, distancia, desnivel) VALUES
    (1, 'Ruta histórica por el Barrio Gótico', 8, 5, 100),
    (2, 'Descubriendo el Modernismo en Barcelona', 7, 8, 150),
    (3, 'Tour arqueológico por Montjuïc', 9, 12, 200),
    (4, 'Paseo cultural por la Ciutadella', 6, 6, 80),
    (5, 'Senderismo en Montserrat', 9, 15, 300),
    (6, 'Explorando el Raval', 7, 7, 120),
    (7, 'Ruta gastronómica en el Born', 8, 4, 60),
    (8, 'Camino a la Sagrada Familia', 6, 10, 180),
    (9, 'Travesía por el Parc de la Ciutadella', 9, 8, 100),
    (10, 'Tour nocturno por el Barrio Gótico', 7, 5, 80);

INSERT INTO Visita_Usuario_Lugar (id_usuario, id_lugar) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 2),
    (7, 4),
    (8, 3),
    (9, 1),
    (7, 2);

INSERT INTO Tiene_Lugar_Comentario (id_lugar, id_comentario) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (4, 6),
    (3, 7),
    (4, 8),
    (2, 9),
    (1, 10);

INSERT INTO Realiza_Usuario_Transaccion (id_usuario, id_transaccion) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (7, 10);

INSERT INTO Paga_Transaccion_Guia (id_transaccion, id_guia) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);

INSERT INTO Escribe_Usuario_Comentario (id_comentario, id_usuario) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 3);

INSERT INTO Contiene_Lugar_Ruta (id_lugar, id_ruta) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (3, 6),
    (3, 7),
    (2, 8),
    (1, 9),
    (3, 10);