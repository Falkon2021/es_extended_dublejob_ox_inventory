function StartPayCheck()
	CreateThread(function()
		while true do
			Wait(Config.PaycheckInterval)
			local xPlayers = ESX.GetExtendedPlayers()
			for _, xPlayer in pairs(xPlayers) do
				local job     = xPlayer.job.grade_name
                local onDuty  = xPlayer.job.onDuty
				local salary  = xPlayer.job.grade_salary

				local job2     = xPlayer.job.grade_name
                local onDuty2  = xPlayer.job2.onDuty
				local salary2  = xPlayer.job2.grade_salary

				if salary > 0 then
					if job == 'unemployed' then -- unemployed
						xPlayer.addAccountMoney('bank', salary)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_MAZE', 9)
					elseif Config.EnableSocietyPayouts and onDuty then -- possibly a society
						TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
							if society ~= nil then -- verified society
								TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
									if account.money >= salary then -- does the society money to pay its employees?
										xPlayer.addAccountMoney('bank', salary)
										account.removeMoney(salary)

										TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
									else
										TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
									end
								end)
							else -- not a society
								xPlayer.addAccountMoney('bank', salary)
								TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
							end
						end)
					elseif onDuty then -- generic job
						xPlayer.addAccountMoney('bank', salary)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
					end
				end

				if salary2 > 0 then
					if job2 == 'unemployed2' then -- unemployed
						xPlayer.addAccountMoney('bank', salary2)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary2), 'CHAR_BANK_MAZE', 9)
					elseif Config.EnableSocietyPayouts and onDuty then -- possibly a society
						TriggerEvent('esx_society:getSociety', xPlayer.job2.name, function (society)
							if society ~= nil then -- verified society
								TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
									if account.money >= salary2 then -- does the society money to pay its employees2?
										xPlayer.addAccountMoney('bank', salary2)
										account.removeMoney(salary2)

										TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary2), 'CHAR_BANK_MAZE', 9)
									else
										TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
									end
								end)
							else -- not a society
								xPlayer.addAccountMoney('bank', salary2)
								TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary2), 'CHAR_BANK_MAZE', 9)
							end
						end)
					elseif onDuty2 then -- generic job
						xPlayer.addAccountMoney('bank', salary2)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary2), 'CHAR_BANK_MAZE', 9)
					end
				end
			end
		end
	end)
end
