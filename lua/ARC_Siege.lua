if Server then


local origrules = ARC.AcquireTarget
function ARC:AcquireTarget() 

local canfire = ( kSideTimer ~= 0 and GetSideDoorOpen() )  or  GetFrontDoorOpen() 
--Print("Arc can fire is %s", canfire)
if not canfire then return end
return origrules(self)

end



end
Script.Load("lua/ResearchMixin.lua")
Script.Load("lua/RecycleMixin.lua")

--Kyle 'Avoca' Abent
class 'ARCSiege' (ARC)
ARCSiege.kMapName = "arcsiege"

local networkVars = 

{


}
AddMixinNetworkVars(ResearchMixin, networkVars)
AddMixinNetworkVars(RecycleMixin, networkVars)
function ARCSiege:OnCreate()
ARC.OnCreate(self)
    InitMixin(self, ResearchMixin)
    InitMixin(self, RecycleMixin)
end

function ARCSiege:OnInitialized()
ARC.OnInitialized(self)
self:SetTechId(kTechId.ARC)
end
        function ARCSiege:GetTechId()
         return kTechId.ARC
end
function ARCSiege:OnGetMapBlipInfo()
    local success = false
    local blipType = kMinimapBlipType.Undefined
    local blipTeam = -1
    local isAttacked = HasMixin(self, "Combat") and self:GetIsInCombat()
    blipType = kMinimapBlipType.ARC
     blipTeam = self:GetTeamNumber()
    if blipType ~= 0 then
        success = true
    end
    
    return success, blipType, blipTeam, isAttacked, false --isParasited
end

    
    
    
 
Shared.LinkClassToMap("ARCSiege", ARCSiege.kMapName, networkVars)
