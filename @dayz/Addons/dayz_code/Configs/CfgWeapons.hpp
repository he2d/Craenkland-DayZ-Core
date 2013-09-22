class CfgWeapons {
	class Default {
		canlock = 0;
	};
	class ItemCore;
	class Crossbow;
	class Rifle;
	class MeleeWeapon : Rifle {
		canDrop = true;
	};
	class PistolCore;
	class Pistol;
	class GrenadeLauncher;
	//class M107_DZ;
	//class BAF_AS50_scoped;
	class DMR;
	class SVD;
	class SVD_CAMO;
	class Single;
	
	#include "CfgWeapons\Melee\MeleeMachete.hpp"
	#include "CfgWeapons\Melee\ItemMachete.hpp"
	#include "CfgWeapons\Melee\MeleeHatchet.hpp"
	#include "CfgWeapons\Melee\ItemHatchet.hpp"
	#include "CfgWeapons\Melee\MeleeCrowbar.hpp"
	#include "CfgWeapons\Melee\ItemCrowbar.hpp"
	#include "CfgWeapons\Melee\Crossbow.hpp"
	#include "CfgWeapons\Melee\MeleeBaseBallBat.hpp"
	#include "CfgWeapons\Melee\MeleeBaseBallBatBarbed.hpp"
	#include "CfgWeapons\Melee\MeleeBaseBallBatNails.hpp"
	#include "CfgWeapons\Melee\MeleeFishingPole.hpp"
	
	#include "CfgWeapons\Item\ItemWatch.hpp"
	#include "CfgWeapons\Item\ItemMap.hpp"
	#include "CfgWeapons\Item\ItemMap_Debug.hpp"
	#include "CfgWeapons\Item\ItemCompass.hpp"
	#include "CfgWeapons\Item\Flashlight.hpp"
	#include "CfgWeapons\Item\Flare.hpp"
	#include "CfgWeapons\Item\ItemEtool.hpp"
	#include "CfgWeapons\Item\ItemShovel.hpp"
	#include "CfgWeapons\Item\ItemFishingPole.hpp"
	
	//Sniper Rifel
	//#include "CfgWeapons\Weapon\Sniper\AS50.hpp"
	//Pistols
	#include "CfgWeapons\Weapon\Pistol\M9.hpp"
	#include "CfgWeapons\Weapon\Pistol\M9SD.hpp"
	#include "CfgWeapons\Weapon\Pistol\G17.hpp"
	#include "CfgWeapons\Weapon\Pistol\M1911.hpp"
	#include "CfgWeapons\Weapon\Pistol\Makarov.hpp"
	#include "CfgWeapons\Weapon\Pistol\MakarovSD.hpp"
	#include "CfgWeapons\Weapon\Pistol\PDW.hpp"
	#include "CfgWeapons\Weapon\Pistol\Revolver.hpp"
	//AR
	class M16_base;
	#include "CfgWeapons\Weapon\AR\M16A2.hpp"
	
	#include "CfgWeapons\Weapon\AR\M16A2GL.hpp"
	#include "CfgWeapons\Weapon\AR\M16A4.hpp"
	#include "CfgWeapons\Weapon\AR\M16A4ACG.hpp"
	#include "CfgWeapons\Weapon\AR\M16A4GL.hpp"
	#include "CfgWeapons\Weapon\AR\M16A4ACGGL.hpp"
	#include "CfgWeapons\Weapon\AR\FNFAL.hpp"
	
	//Sniper
	#include "CfgWeapons\Weapon\Sniper\M107.hpp"
	#include "CfgWeapons\Weapon\Sniper\DMR_DZ.hpp"
	#include "CfgWeapons\Weapon\Sniper\SVD_DZ.hpp"
	#include "CfgWeapons\Weapon\Sniper\SVD_CAMO_DZ.hpp"
};