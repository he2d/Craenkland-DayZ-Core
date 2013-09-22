class CardboardBox;
class FoodBox0 : CardboardBox {
	scope = public;
	displayName = $STR_DAYZ_OBJ_1;
	model = "\dayz_equip\models\cardboard_box.p3d";
	
	class transportmagazines {
		class _xx_FoodCanBakedBeans {
			magazine = "FoodCanBakedBeans";
			count = 6;
		};
		
		class _xx_FoodCanSardines {
			magazine = "FoodCanSardines";
			count = 6;
		};
		
		class _xx_FoodCanFrankBeans {
			magazine = "FoodCanFrankBeans";
			count = 6;
		};
		
		class _xx_FoodCanPasta {
			magazine = "FoodCanPasta";
			count = 6;
		};
	};
};

class FoodBox1 : FoodBox0 {};

class FoodBox2 : FoodBox0 {};

class MedBox1 : CardboardBox {
	scope = public;
	displayName = $STR_DAYZ_OBJ_2;
	model = "\dayz_equip\models\cardboard_box_med.p3d";
	
	class transportmagazines {
		class _xx_ItemBandage {
			magazine = "ItemBandage";
			count = 5;
		};
		
		class _xx_ItemEpinephrine {
			magazine = "ItemEpinephrine";
			count = 2;
		};
		
		class _xx_ItemMorphine {
			magazine = "ItemMorphine";
			count = 5;
		};
		
		class _xx_ItemBloodbag {
			magazine = "ItemBloodbag";
			count = 2;
		};
		
		class _xx_ItemPainkiller {
			magazine = "ItemPainkiller";
			count = 2;
		};
		
		class _xx_ItemAntibiotic {
			magazine = "ItemAntibiotic";
			count = 3;
		};
	};
};