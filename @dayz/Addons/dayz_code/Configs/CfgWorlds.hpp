class DayLightingBrightAlmost;	// External class reference
class DefaultClutter;	// External class reference
class Grid;	// External class reference
class DefaultLighting;	// External class reference
class DayLightingRainy;	// External class reference
class Weather;	// External class reference

class CfgWorlds {
	class Chernarus;	// External class reference
	class DayZMod : Chernarus {
		access = 3;
		worldId = 4;
		cutscenes[] = {"DayZModIntro1"};
		description = "DayZMod v1.8";
		icon = "";
		worldName = "\ca\chernarus\chernarus.wrp";
		pictureMap = "";
		pictureShot = "\ca\chernarus\data\ui_selectisland_chernarus_ca.paa";
		plateFormat = "ML$ - #####";
		plateLetters = "ABCDEGHIKLMNOPRSTVXZ";
		longitude = 30;
		latitude = -45;
		class OutsideTerrain
		{
			satellite = "ca\CHERNARUS\data\s_satout_co.paa";
			enableTerrainSynth = 1;
			class Layers
			{
				class Layer0
				{
					nopx = "ca\CHERNARUS\data\cr_trava1_detail_nopx.paa";
					texture = "ca\CHERNARUS\data\cr_trava1_detail_co.paa";
				};
			};
		};
		class Grid: Grid
		{
			offsetX = 0;
			offsetY = 0;
			class Zoom1
			{
				zoomMax = 0.15;
				format = "XY";
				formatX = "000";
				formatY = "000";
				stepX = 100;
				stepY = 100;
			};
			class Zoom2
			{
				zoomMax = 0.85;
				format = "XY";
				formatX = "00";
				formatY = "00";
				stepX = 1000;
				stepY = 1000;
			};
			class Zoom3
			{
				zoomMax = 1e+030;
				format = "XY";
				formatX = "0";
				formatY = "0";
				stepX = 10000;
				stepY = 10000;
			};
		};
		startTime = "9:20";
		startDate = "11/10/2008";
		startWeather = 0.25;
		startFog = 0.0;
		forecastWeather = 0.25;
		forecastFog = 0.0;
		centerPosition[] = {7100,7750,300};
		seagullPos[] = {1272.842,150.0,14034.962};
		ilsPosition[] = {4887.5,9660};
		ilsDirection[] = {0.5075,0.08,-0.8616};
		ilsTaxiIn[] = {4785.21,10174.29,5024.903,9759.071,5027.385,9737.021,5015.327,9721.136,4928.958,9670.509,4906.105,9664.372,4880.936,9673.65};
		ilsTaxiOff[] = {4671,10038,4195.5,10862.011,4201.01,10885.8,4218.536,10899.822,4304.679,10950.154,4324.962,10953.66,4345.746,10938.886,4785.21,10174.29};
		drawTaxiway = 1;
		class SecondaryAirports
		{
			class ChernarusAirstrip1
			{
				ilsPosition[] = {12461,12585};
				ilsDirection[] = {0.9396,0.08,-0.342};
				ilsTaxiIn[] = {12125.9,12669.3,12435.5,12562.1,12442,12561,12447,12564,12453.3,12575.2,12454.3,12581,12451.4,12586};
				ilsTaxiOff[] = {12204.4,12681.9,11812.1,12824.1,11804.1,12824.4,11797.8,12818.8,11790.9,12801.5,11790.6,12793.6,11796.6,12788.6,12125.9,12669.3};
				drawTaxiway = 0;
			};
			class ChernarusAirstrip2
			{
				ilsPosition[] = {5223,2220.5};
				ilsDirection[] = {0.866,0.08,-0.5};
				ilsTaxiIn[] = {5009.9,2374.2,5240.3,2243.2,5243.3,2238.4,5242.7,2232.1,5235.9,2221.1,5229.7,2216.6,5221.5,2217.3};
				ilsTaxiOff[] = {5070,2308,4640.8,2551.9,4638.3,2557,4639.3,2563.3,4646.5,2573.9,4651.3,2578.5,4658.5,2577.9,5009.9,2374.2};
				drawTaxiway = 0;
			};
		};
		class ReplaceObjects{};
		class Sounds
		{
			sounds[] = {};
		};
		class Animation
		{
			vehicles[] = {};
		};
		class Lighting: DefaultLighting
		{
			groundReflection[] = {0.06,0.06,0.03};
		};
		class DayLightingBrightAlmost: DayLightingBrightAlmost
		{
			deepNight[] = {-15,
				{ 0.05,0.05,0.06 },
				{ 0.001,0.001,0.002 },
				{ 0.02,0.02,0.05 },
				{ 0.003,0.003,0.003 },
				{ 0.0001,0.0001,0.0002 },
				{ 0.0001,0.0001,0.0002 },0};
			fullNight[] = {-5,
				{ 0.05,0.05,0.05 },
				{ 0.02,0.02,0.02 },
				{ 0.04,0.04,0.04 },
				{ 0.04,0.04,0.04 },
				{ 0.01,0.01,0.02 },
				{ 0.08,0.06,0.06 },0};
			sunMoon[] = {-3.75,
				{ 0.045,0.04,0.04 },
				{ 0.04,0.04,0.04 },
				{ 0.045,0.04,0.04 },
				{ 0.04,0.04,0.04 },
				{ 0.04,0.035,0.04 },
				{ 0.1,0.08,0.09 },0.5};
			earlySun[] = {-2.5,
				{ 0.12,0.1,0.1 },
				{ 0.08,0.06,0.07 },
				{ 0.12,0.1,0.1 },
				{ 0.08,0.06,0.07 },
				{ 0.08,0.07,0.08 },
				{ 0.1,0.1,0.12 },1};
			sunrise[] = {0,
				{ 
					{ 0.7,0.45,0.45 },"5.16+(-4)" },
				{ 
					{ 0.07,0.09,0.12 },"4.0+(-4)" },
				{ 
					{ 0.6,0.47,0.25 },"4.66+(-4)" },
				{ 
					{ 0.1,0.09,0.1 },"4.3+(-4)" },
				{ 
					{ 0.5,0.4,0.4 },"6.49+(-4)" },
				{ 
					{ 0.88,0.51,0.24 },"8.39+(-4)" },1};
			earlyMorning[] = {3,
				{ 
					{ 0.65,0.55,0.55 },"6.04+(-4)" },
				{ 
					{ 0.08,0.09,0.11 },"4.5+(-4)" },
				{ 
					{ 0.55,0.47,0.25 },"5.54+(-4)" },
				{ 
					{ 0.1,0.09,0.1 },"5.02+(-4)" },
				{ 
					{ 0.5,0.4,0.4 },"7.05+(-4)" },
				{ 
					{ 0.88,0.51,0.24 },"8.88+(-4)" },1};
			midMorning[] = {8,
				{ 
					{ 0.98,0.85,0.8 },"8.37+(-4)" },
				{ 
					{ 0.08,0.09,0.11 },"6.42+(-4)" },
				{ 
					{ 0.87,0.47,0.25 },"7.87+(-4)" },
				{ 
					{ 0.09,0.09,0.1 },"6.89+(-4)" },
				{ 
					{ 0.5,0.4,0.4 },"8.9+(-4)" },
				{ 
					{ 0.88,0.51,0.24 },"10.88+(-4)" },1};
			morning[] = {16,
				{ 
					{ 1,1,0.9 },"13.17+(-4)" },
				{ 
					{ 0.17,0.18,0.19 },"10.26+(-4)" },
				{ 
					{ 1,1,0.9 },"12.67+(-4)" },
				{ 
					{ 0.17,0.18,0.19 },"11.71+(-4)" },
				{ 
					{ 0.15,0.15,0.15 },"12.42+(-4)" },
				{ 
					{ 0.17,0.17,0.15 },"14.42+(-4)" },1};
			noon[] = {45,
				{ 
					{ 1,1,1 },"17+(-4)" },
				{ 
					{ 1,1.3,1.55 },"13.5+(-4)" },
				{ 
					{ 1,1,1 },"15+(-4)" },
				{ 
					{ 0.36,0.37,0.38 },"13.5+(-4)" },
				{ 
					{ 1,1,1 },"16+(-4)" },
				{ 
					{ 1.0,1.0,1 },"17+(-4)" },1};
		};
		class DayLightingRainy: DayLightingRainy
		{
			deepNight[] = {-15,
				{ 0.0034,0.0034,0.004 },
				{ 0.003,0.003,0.003 },
				{ 0.0034,0.0034,0.004 },
				{ 0.003,0.003,0.003 },
				{ 0.001,0.001,0.002 },
				{ 0.001,0.001,0.002 },0};
			fullNight[] = {-5,
				{ 0.023,0.023,0.023 },
				{ 0.02,0.02,0.02 },
				{ 0.023,0.023,0.023 },
				{ 0.02,0.02,0.02 },
				{ 0.01,0.01,0.02 },
				{ 0.08,0.06,0.06 },0};
			sunMoon[] = {-3.75,
				{ 0.04,0.04,0.05 },
				{ 0.04,0.04,0.05 },
				{ 0.04,0.04,0.05 },
				{ 0.04,0.04,0.05 },
				{ 0.04,0.035,0.04 },
				{ 0.11,0.08,0.09 },0.5};
			earlySun[] = {-2.5,
				{ 0.0689,0.0689,0.0804 },
				{ 0.06,0.06,0.07 },
				{ 0.0689,0.0689,0.0804 },
				{ 0.06,0.06,0.07 },
				{ 0.08,0.07,0.08 },
				{ 0.14,0.1,0.12 },0.5};
			earlyMorning[] = {0,
				{ 
					{ 1,1,1 },"(-4)+3.95" },
				{ 
					{ 1,1,1 },"(-4)+3.0" },
				{ 
					{ 1,1,1 },"(-4)+3.95" },
				{ 
					{ 1,1,1 },"(-4)+3.0" },
				{ 
					{ 1,1,1 },"(-4)+4" },
				{ 
					{ 1,1,1 },"(-4)+5.5" },1};
			morning[] = {5,
				{ 
					{ 1,1,1 },"(-4)+5.7" },
				{ 
					{ 1,1,1 },"(-4)+4.5" },
				{ 
					{ 1,1,1 },"(-4)+5.7" },
				{ 
					{ 1,1,1 },"(-4)+4.5" },
				{ 
					{ 1,1,1 },"(-4)+7" },
				{ 
					{ 1,1,1 },"(-4)+8" },1};
			lateMorning[] = {25,
				{ 
					{ 1,1,1 },"(-4)+10.45" },
				{ 
					{ 1,1,1 },"(-4)+9.75" },
				{ 
					{ 1,1,1 },"(-4)+10.45" },
				{ 
					{ 1,1,1 },"(-4)+9.75" },
				{ 
					{ 1,1,1 },"(-4)+12" },
				{ 
					{ 1,1,1 },"(-4)+12.75" },1};
			noon[] = {70,
				{ 
					{ 1,1,1 },"(-4)+12.5" },
				{ 
					{ 1,1,1 },"(-4)+11" },
				{ 
					{ 1,1,1 },"(-4)+12" },
				{ 
					{ 1,1,1 },"(-4)+11" },
				{ 
					{ 1,1,1 },"(-4)+13.5" },
				{ 
					{ 1,1,1 },"(-4)+14" },1};
		};
		class Weather: Weather
		{
			class Lighting: Lighting
			{
				class BrightAlmost: DayLightingBrightAlmost
				{
					overcast = 0;
				};
				class Rainy: DayLightingRainy
				{
					overcast = 1.0;
				};
			};
		};
	};

	initWorld = "DayZMod";
	demoWorld = "DayZMod";
};

class CfgWorldList {
	class DayZMod {};
};