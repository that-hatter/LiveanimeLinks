--Gouki The Blade Ogre
function c511009017.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c511009017.matfilter,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511009017.atkval)
	c:RegisterEffect(e1)
	--multiatk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21954587,2))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511009017.atkcon)
	e2:SetCost(c511009017.atkcost)
	e2:SetTarget(c511009017.atktg)
	e2:SetOperation(c511009017.atkop)
	c:RegisterEffect(e2)
end
function c511009017.matfilter(c)
	return c:IsLinkSetCard(0xfc)
end
function c511009017.atkval(e,c)
	return c:GetLinkedGroupCount()*300
end
function c511009017.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c511009017.cfilter(c,g)
	return g:IsContains(c) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511009017.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c511009017.cfilter,1,false,nil,nil,lg) end
	local g=Duel.SelectReleaseGroupCost(tp,c511009017.cfilter,1,1,false,nil,nil,lg)
	Duel.Release(g,REASON_COST)
end
function c511009017.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK)==0 end
end
function c511009017.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
