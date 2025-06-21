--Generated on 30 Apr 2024 @ 08:54 (UTC) with Version 3.0 of PatchBuilder.
--MID: 101421; CID: 40300; Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo 
--Script with 32/64-bit settings.
USE CASINO;
GO
SET NOCOUNT ON;
--------------------------------------------------------------------------------------------
--WARNING!Only set the following variable to 1 if you are under specific instruction to do so
--and have operator consent to override any default values that they may have applied to the system.
--------------------------------------------------------------------------------------------
DECLARE @ForceUpdate INT;
DECLARE @Msg VARCHAR(MAX);
SET @ForceUpdate = 0;
--------------------------------------------------------------------------------------------
--Region to check tb_ExcludeModule
--------------------------------------------------------------------------------------------
IF EXISTS (SELECT 1 FROM tb_ExcludeModule WHERE ModuleID = 101421)
BEGIN
    RAISERROR(
                 N'Warning: Updating settings for a game variant (ModuleId 101421, ClientId 40300) whose ModuleId is in tb_ExcludeModule',
                 10,
                 1
             );
    PRINT('');
    DELETE FROM tb_ExcludeModule WHERE ModuleID = 101421;
END;
--------------------------------------------------------------------------------------------
--End tb_ExcludeModule Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Start Transaction
--------------------------------------------------------------------------------------------
BEGIN TRANSACTION;
--------------------------------------------------------------------------------------------
--Region Create tb_Module, tb_ModuleTheoretical Information
--------------------------------------------------------------------------------------------
BEGIN TRY
    UPDATE tb_Module
    SET ModuleName = 'Candy Combo™ - Power Combo'
    WHERE ModuleID =  101421;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT tb_Module
        (
            ModuleID,
            ModuleName,
            ModuleIP
        )
        VALUES
        ( 101421, 'Candy Combo™ - Power Combo', '');
    END;
    --Check tb_ModuleTheoretical
    UPDATE dbo.tb_ModuleTheoretical
    SET Theoretical = dbo.clr_fn_LSR_EncryptData(96)
    WHERE ModuleID = 101421;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT dbo.tb_ModuleTheoretical
        (
            ModuleID,
            Theoretical
        )
        VALUES
        (101421, dbo.clr_fn_LSR_EncryptData(96));
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR:Error in Region Module for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_Module,tb_ModuleTheoretical Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Region Update Game Categories(Game Archiving and Grouping according to revenue stream)
--------------------------------------------------------------------------------------------
BEGIN TRY
    DECLARE @GameGroupTypeID INT,
            @GameGroupID INT,
            @BasicGameGroupID INT;


    --MGS Archiving Groups 
    SELECT @GameGroupTypeID = GameGroupTypeID
    FROM tb_GameGroupType
    WHERE Description = 'MGS Archiving Groups';

    --Extensible Game
    SELECT @GameGroupID = GameGroupID
    FROM tb_GameGroup
    WHERE Description = 'Extensible Game'
          AND GameGroupTypeID = @GameGroupTypeID;

    DECLARE @GameArchivingGroupDescription NVARCHAR(50);
    SET @GameArchivingGroupDescription = N'MGS Archiving Groups';
    DECLARE @GameArchivingGroupID INT;
    SET @GameArchivingGroupID = @GameGroupID;

    SELECT @BasicGameGroupID = GameGroupID
    FROM tb_BasicGameGroup
    WHERE GameGroupID = @GameGroupID;

    IF (
           @GameGroupTypeID IS NULL
           OR @GameGroupID IS NULL
           OR @BasicGameGroupID IS NULL
       )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR(N'ERROR: Cound not find Game Group ID or Game Group Type: ''MGS Archiving Groups''', 15, 1);
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM tb_BasicGameGroupMember
        WHERE GameGroupID = @GameGroupID
              AND ModuleID = 101421 )

    BEGIN
        DELETE FROM tb_BasicGameGroupMember
        WHERE ModuleId = 101421 AND GameGroupID <> @GameGroupID AND GameGroupID IN
            (SELECT GameGroupID FROM tb_GameGroup
                WHERE GameGroupTypeID = @GameGroupTypeID)
    END;
    ELSE
    BEGIN
        DELETE FROM tb_BasicGameGroupMember
        WHERE ModuleId = 101421 AND GameGroupID IN
            (SELECT GameGroupID FROM tb_GameGroup
                WHERE GameGroupTypeID = @GameGroupTypeID)
        INSERT tb_BasicGameGroupMember
        (
            GameGroupID,
            ModuleID
        )
        VALUES
        (@GameGroupID, 101421);
    END;

    --Game Category 
    SELECT @GameGroupTypeID = GameGroupTypeID
    FROM tb_GameGroupType
    WHERE Description = 'Game Category';

    --Slots
    SELECT @GameGroupID = GameGroupID
    FROM tb_GameGroup
    WHERE Description = 'Slots'
          AND GameGroupTypeID = @GameGroupTypeID;


    SELECT @BasicGameGroupID = GameGroupID
    FROM tb_BasicGameGroup
    WHERE GameGroupID = @GameGroupID;

    IF (
           @GameGroupTypeID IS NULL
           OR @GameGroupID IS NULL
           OR @BasicGameGroupID IS NULL
       )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR(N'ERROR: Cound not find Game Group ID or Game Group Type: ''Game Category''', 15, 1);
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM tb_BasicGameGroupMember
        WHERE GameGroupID = @GameGroupID
              AND ModuleID = 101421 )

    BEGIN
        DELETE FROM tb_BasicGameGroupMember
        WHERE ModuleId = 101421 AND GameGroupID <> @GameGroupID AND GameGroupID IN
            (SELECT GameGroupID FROM tb_GameGroup
                WHERE GameGroupTypeID = @GameGroupTypeID)
    END;
    ELSE
    BEGIN
        DELETE FROM tb_BasicGameGroupMember
        WHERE ModuleId = 101421 AND GameGroupID IN
            (SELECT GameGroupID FROM tb_GameGroup
                WHERE GameGroupTypeID = @GameGroupTypeID)
        INSERT tb_BasicGameGroupMember
        (
            GameGroupID,
            ModuleID
        )
        VALUES
        (@GameGroupID, 101421);
    END;

    --Free Game Betting Model 
    SELECT @GameGroupTypeID = GameGroupTypeID
    FROM tb_GameGroupType
    WHERE Description = 'Free Game Betting Model';

    --Slot
    SELECT @GameGroupID = GameGroupID
    FROM tb_GameGroup
    WHERE Description = 'Slot'
          AND GameGroupTypeID = @GameGroupTypeID;


    SELECT @BasicGameGroupID = GameGroupID
    FROM tb_BasicGameGroup
    WHERE GameGroupID = @GameGroupID;

    IF (
           @GameGroupTypeID IS NULL
           OR @GameGroupID IS NULL
           OR @BasicGameGroupID IS NULL
       )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR(N'ERROR: Cound not find Game Group ID or Game Group Type: ''Free Game Betting Model''', 15, 1);
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM tb_BasicGameGroupMember
        WHERE GameGroupID = @GameGroupID
              AND ModuleID = 101421 )

    BEGIN
        DELETE FROM tb_BasicGameGroupMember
        WHERE ModuleId = 101421 AND GameGroupID <> @GameGroupID AND GameGroupID IN
            (SELECT GameGroupID FROM tb_GameGroup
                WHERE GameGroupTypeID = @GameGroupTypeID)
    END;
    ELSE
    BEGIN
        DELETE FROM tb_BasicGameGroupMember
        WHERE ModuleId = 101421 AND GameGroupID IN
            (SELECT GameGroupID FROM tb_GameGroup
                WHERE GameGroupTypeID = @GameGroupTypeID)
        INSERT tb_BasicGameGroupMember
        (
            GameGroupID,
            ModuleID
        )
        VALUES
        (@GameGroupID, 101421);
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR:Error in  Region Game Categories for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
----End tb_BasicGameGroupMember Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Region Update Default Language Game Name(Friendly Game Name)
--------------------------------------------------------------------------------------------
DECLARE @TranslationStringID INT = NULL;
BEGIN TRY
    UPDATE tb_TranslationContext
    SET IsTranslationUpdatable = 1
    WHERE TranslationContextID = 3;
    EXEC dbo.pr_AddDefaultTranslationString 3,
                                        N'Candy Combo™ - Power Combo',
                                        @TranslationStringID OUTPUT;
    IF NOT EXISTS
    (
        SELECT 1
        FROM tb_TranslatedString
        WHERE TranslationContextID = 3
              AND TranslationStringID = @TranslationStringID
              AND LanguageID = 1
    )
    BEGIN
        EXEC dbo.pr_AddTranslatedString @TranslationStringID, 
                                        3,
                                        1,
                                        N'Candy Combo™ - Power Combo';
    END;
    UPDATE tb_TranslationContext
    SET IsTranslationUpdatable = 0
    WHERE TranslationContextID = 3;

    UPDATE tb_InstalledClients
    SET ClientName = 'Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo',
        ClientTypeID = 40,
        TranslationContextID = 3,
        TranslationStringID = @TranslationStringID
    WHERE ModuleID = 101421
          AND ClientID = 40300;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT tb_InstalledClients
        (
            ModuleID,
            ClientID,
            ClientName,
            TranslationContextID,
            TranslationStringID,
            ClientTypeID
        )
        VALUES
        (101421, 40300, 'Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo', 3, @TranslationStringID, 40);
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in  Region Default Language Game Name for ModuleID 101421, ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_InstalledClients Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Update Common Game Settings
--------------------------------------------------------------------------------------------
BEGIN TRY
    DECLARE @GameSettings TABLE
    (
        ModuleID INT,
        ClientID INT,
        Name CHAR(50),
        IntValue INT,
        StrValue VARCHAR(255),
        PRIMARY KEY(
                        ModuleID,
                        ClientID,
                        Name
                    )
    );

    INSERT INTO @GameSettings
    VALUES

          (101421, 40300, 'HasBonusFeature', 1, NULL),
          (101421, 40300, 'HasGambleFeature', 0, NULL),
          (101421, 40300, 'HasFreeSpinFeature', 1, NULL),
          (101421, 40300, 'HasNudgeFeature', 0, NULL),
          (101421, 40300, 'IsWayGame', 0, NULL),
          (101421, 40300, 'PaylineCountWithCost', 10, NULL)
    MERGE tb_GameSettings t
    USING @GameSettings s
    ON (
           s.ModuleID = t.ModuleID
           AND s.ClientID = t.ClientID
           AND t.Name = s.Name
       )
    WHEN MATCHED AND s.IntValue IS NULL AND s.StrValue IS NULL THEN
        DELETE
    WHEN MATCHED THEN
        UPDATE SET t.IntValue = s.IntValue,
                   t.StrValue = s.StrValue
    WHEN NOT MATCHED AND (s.IntValue IS NOT NULL OR s.StrValue IS NOT NULL) THEN
        INSERT
        (
            ModuleID,
            ClientID,
            Name,
            IntValue,
            StrValue
        )
        VALUES
        (s.ModuleID, s.ClientID, s.Name, s.IntValue, s.StrValue);
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR:  Error in  Region Common Game Setting  for ModuleID 101421, ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_GameSettings Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Default Module Setting Information Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Install tb_BetModel ,tb_BetModelSetting , tb_BetModelGame for  101421,40300,Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo
--------------------------------------------------------------------------------------------
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM tb_BetModel WHERE BetModelID = 64)
    BEGIN
        PRINT N'Bet Model does not currently exist, creating...';
        INSERT INTO tb_BetModel
        (
            BetModelID,
            BetModelName
        )
        SELECT 64,
              'Http Slot Game With MaxPurchaseBet';

        INSERT INTO tb_BetModelSetting
        (
            BetModelID,
            SettingID
        )
        VALUES
        --Adding setting 'MaxBet' to the bet model
        (64,105)
        --Adding setting 'MinBet' to the bet model
        ,(64,106)
        --Adding setting 'DefaultBet' to the bet model
        ,(64,214)
        --Adding setting 'MinCoinsPerLineOrWay' to the bet model
        ,(64,952)
        --Adding setting 'MaxCoinsPerLineOrWay' to the bet model
        ,(64,955)
        --Adding setting 'DefaultCoinsPerLineOrWay' to the bet model
        ,(64,956)
        --Adding setting 'MinBetMultiplier' to the bet model
        ,(64,948)
        --Adding setting 'MaxBetMultiplier' to the bet model
        ,(64,949)
        --Adding setting 'DefaultBetMultiplier' to the bet model
        ,(64,950)
        --Adding setting 'MaxPurchaseBet' to the bet model
        ,(64,953)

       IF @@ROWCOUNT <> 10
       BEGIN
           ROLLBACK TRANSACTION;
           RAISERROR(N'ERROR: The Bet Model could not be successfully installed!', 15, 1);
           RETURN;
       END;
       PRINT N'Bet Model created successfully!';
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in Region Bet Model for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM tb_BetModelGame WHERE ModuleID = 101421)
    BEGIN
        INSERT INTO tb_BetModelGame
        (
           BetModelID,
           ModuleID
        )
        SELECT 64,
               101421; 
    END;
    ELSE
    BEGIN
        IF NOT EXISTS
        (
            SELECT 1
            FROM tb_BetModelGame
            WHERE ModuleID = 101421
                  AND BetModelID = 64
        )
        BEGIN
            -- Move the bet model. We have to do this for all clients.
            DELETE FROM tb_SettingTemplateValue
            WHERE ModuleID = 101421;

            DELETE FROM tb_BetModelGame
            WHERE ModuleID = 101421;

            INSERT INTO tb_BetModelGame
            (
                BetModelID,
                ModuleID
            )
            SELECT 64,
                   101421; 
        END;
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in Region Bet Model for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_BetModel ,tb_BetModelSetting , tb_BetModelGame Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Install tb_SettingTemplate for 101421,40300,Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo
--------------------------------------------------------------------------------------------
BEGIN TRY
    DECLARE @SettingTemplate TABLE
    (
        TemplateName VARCHAR(255),
        TemplateID INT NOT NULL PRIMARY KEY
    );
    INSERT INTO @SettingTemplate
    VALUES
    ('Default Settings',0)
    ,('Low Settings',1)
    ,('High Settings',2)
    ,('2 X Multiplier',3)
    ,('5 X Multiplier',4)
    ,('10 X Multiplier',5)
    ,('50 X Multiplier',6)
    ,('100 X Multiplier',7)
    ,('1000 X Multiplier',8)
    ,('25 X Multiplier',9)
    ,('500 X Multiplier',10)
    ,('Bingo',11)
    ,('Wide Settings',12)
    ,('20 x Multiplier',13)
    ,('200 X Multiplier',14)
    ,('5000 X Multiplier',15)
    ,('10000 X Multiplier',16)
    ,('2000 X Multiplier',17)

    MERGE tb_SettingTemplate t
    USING @SettingTemplate s
    ON (s.TemplateID = t.TemplateID)
    WHEN MATCHED THEN
        UPDATE SET t.TemplateName = s.TemplateName
    WHEN NOT MATCHED THEN
        INSERT
        (
            TemplateName,
            TemplateID
        )
        VALUES
        (s.TemplateName, s.TemplateID);
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in  Region Setting Template  for ModuleID 101421, ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_SettingTemplate Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Install tb_SettingTemplateValue for 101421, 40300, Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo
--------------------------------------------------------------------------------------------

DECLARE @IsLvcsEnabled BIT = 0;
IF EXISTS (SELECT 1 FROM tb_SystemSetting WHERE SystemSettingID = 87 AND SystemSettingIntValue = 1)
BEGIN
    SET @IsLvcsEnabled = 1;
END;

BEGIN TRY
    DELETE FROM tb_SettingTemplateValue
    WHERE TemplateID IN ( 0,1,2,4,5,6,7,8,10,13,14,15,16,17 )
          AND ModuleID = 101421
          AND ClientID = 40300;
    BEGIN
        INSERT INTO tb_SettingTemplateValue
        (
            TemplateID,
            ModuleID,
            ClientID,
            SettingID,
            BetModelID,
            SettingIntValue,
            SettingStringValue
        )
        VALUES
        --TemplateID:-0
        (0,101421,40300,105,64,2500, NULL)
        --TemplateID:-0
        ,(0,101421,40300,106,64,20, NULL)
        --TemplateID:-0
        ,(0,101421,40300,214,64,200, NULL)
        --TemplateID:-0
        ,(0,101421,40300,952,64,1, NULL)
        --TemplateID:-0
        ,(0,101421,40300,955,64,10, NULL)
        --TemplateID:-0
        ,(0,101421,40300,956,64,10, NULL)
        --TemplateID:-0
        ,(0,101421,40300,948,64,10, NULL)
        --TemplateID:-0
        ,(0,101421,40300,949,64,10, NULL)
        --TemplateID:-0
        ,(0,101421,40300,950,64,10, NULL)
        --TemplateID:-0
        ,(0,101421,40300,953,64,-1, NULL)
        --TemplateID:-1
        ,(1,101421,40300,105,64,2500, NULL)
        --TemplateID:-1
        ,(1,101421,40300,106,64,20, NULL)
        --TemplateID:-1
        ,(1,101421,40300,214,64,200, NULL)
        --TemplateID:-1
        ,(1,101421,40300,952,64,1, NULL)
        --TemplateID:-1
        ,(1,101421,40300,955,64,10, NULL)
        --TemplateID:-1
        ,(1,101421,40300,956,64,10, NULL)
        --TemplateID:-1
        ,(1,101421,40300,948,64,10, NULL)
        --TemplateID:-1
        ,(1,101421,40300,949,64,10, NULL)
        --TemplateID:-1
        ,(1,101421,40300,950,64,10, NULL)
        --TemplateID:-1
        ,(1,101421,40300,953,64,-1, NULL)
        --TemplateID:-2
        ,(2,101421,40300,105,64,2500, NULL)
        --TemplateID:-2
        ,(2,101421,40300,106,64,20, NULL)
        --TemplateID:-2
        ,(2,101421,40300,214,64,200, NULL)
        --TemplateID:-2
        ,(2,101421,40300,952,64,1, NULL)
        --TemplateID:-2
        ,(2,101421,40300,955,64,10, NULL)
        --TemplateID:-2
        ,(2,101421,40300,956,64,10, NULL)
        --TemplateID:-2
        ,(2,101421,40300,948,64,10, NULL)
        --TemplateID:-2
        ,(2,101421,40300,949,64,10, NULL)
        --TemplateID:-2
        ,(2,101421,40300,950,64,10, NULL)
        --TemplateID:-2
        ,(2,101421,40300,953,64,-1, NULL)
        --TemplateID:-4
        ,(4,101421,40300,105,64,10000, NULL)
        --TemplateID:-4
        ,(4,101421,40300,106,64,100, NULL)
        --TemplateID:-4
        ,(4,101421,40300,214,64,1000, NULL)
        --TemplateID:-4
        ,(4,101421,40300,953,64,-1, NULL)
        --TemplateID:-5
        ,(5,101421,40300,105,64,20000, NULL)
        --TemplateID:-5
        ,(5,101421,40300,106,64,200, NULL)
        --TemplateID:-5
        ,(5,101421,40300,214,64,2000, NULL)
        --TemplateID:-5
        ,(5,101421,40300,953,64,-1, NULL)
        --TemplateID:-6
        ,(6,101421,40300,105,64,100000, NULL)
        --TemplateID:-6
        ,(6,101421,40300,106,64,1000, NULL)
        --TemplateID:-6
        ,(6,101421,40300,214,64,10000, NULL)
        --TemplateID:-6
        ,(6,101421,40300,953,64,-1, NULL)
        --TemplateID:-7
        ,(7,101421,40300,106,64,2000, NULL)
        --TemplateID:-7
        ,(7,101421,40300,214,64,20000, NULL)
        --TemplateID:-7
        ,(7,101421,40300,953,64,-1, NULL)
        --TemplateID:-10
        ,(10,101421,40300,106,64,10000, NULL)
        --TemplateID:-10
        ,(10,101421,40300,214,64,100000, NULL)
        --TemplateID:-10
        ,(10,101421,40300,953,64,-1, NULL)
        --TemplateID:-13
        ,(13,101421,40300,105,64,50000, NULL)
        --TemplateID:-13
        ,(13,101421,40300,106,64,250, NULL)
        --TemplateID:-13
        ,(13,101421,40300,214,64,2500, NULL)
        --TemplateID:-13
        ,(13,101421,40300,953,64,-1, NULL)
        --TemplateID:-14
        ,(14,101421,40300,106,64,2000, NULL)
        --TemplateID:-14
        ,(14,101421,40300,214,64,20000, NULL)
        --TemplateID:-14
        ,(14,101421,40300,953,64,-1, NULL)
    END;

    IF @IsLvcsEnabled = 0
    BEGIN
        INSERT INTO tb_SettingTemplateValue
        (
            TemplateID,
            ModuleID,
            ClientID,
            SettingID,
            BetModelID,
            SettingIntValue,
            SettingStringValue
        )
        VALUES
        --TemplateID:-7
        (7,101421,40300,105,64,200000, NULL)
        --TemplateID:-10
        ,(10,101421,40300,105,64,200000, NULL)
        --TemplateID:-14
        ,(14,101421,40300,105,64,200000, NULL)
    END;

    IF @IsLvcsEnabled = 1
    BEGIN
        INSERT INTO tb_SettingTemplateValue
        (
            TemplateID,
            ModuleID,
            ClientID,
            SettingID,
            BetModelID,
            SettingIntValue,
            SettingStringValue
        )
        VALUES
        --TemplateID:-7
        (7,101421,40300,105,64,250000, NULL)
        --TemplateID:-8
        ,(8,101421,40300,105,64,2000000, NULL)
        --TemplateID:-8
        ,(8,101421,40300,106,64,20000, NULL)
        --TemplateID:-8
        ,(8,101421,40300,214,64,200000, NULL)
        --TemplateID:-8
        ,(8,101421,40300,953,64,-1, NULL)
        --TemplateID:-10
        ,(10,101421,40300,105,64,1000000, NULL)
        --TemplateID:-14
        ,(14,101421,40300,105,64,500000, NULL)
        --TemplateID:-15
        ,(15,101421,40300,105,64,10000000, NULL)
        --TemplateID:-15
        ,(15,101421,40300,106,64,100000, NULL)
        --TemplateID:-15
        ,(15,101421,40300,214,64,1000000, NULL)
        --TemplateID:-15
        ,(15,101421,40300,953,64,-1, NULL)
        --TemplateID:-16
        ,(16,101421,40300,105,64,20000000, NULL)
        --TemplateID:-16
        ,(16,101421,40300,106,64,200000, NULL)
        --TemplateID:-16
        ,(16,101421,40300,214,64,2000000, NULL)
        --TemplateID:-16
        ,(16,101421,40300,953,64,-1, NULL)
        --TemplateID:-17
        ,(17,101421,40300,105,64,5000000, NULL)
        --TemplateID:-17
        ,(17,101421,40300,106,64,25000, NULL)
        --TemplateID:-17
        ,(17,101421,40300,214,64,250000, NULL)
        --TemplateID:-17
        ,(17,101421,40300,953,64,-1, NULL)
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in  Region Setting Template Value  for ModuleID 101421, ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_SettingTemplateValue Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Install tb_MGSDefaultModuleSetting for  101421   , 40300, Slingshot - HTML5 - Slot - Candy Combo™ - Power Combo 
--------------------------------------------------------------------------------------------
BEGIN TRY
    --Setting for 'BonusSystem - Wager Contribution Percentage'
    UPDATE tb_MGSDefaultModuleSetting
    SET SettingIntValue = 100,
        SettingStringValue = NULL
    WHERE ModuleID = 101421
          AND ClientID = 0
          AND SettingID = 102;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO tb_MGSDefaultModuleSetting
        (
            ModuleID,
            ClientID,
            SettingID,
            SettingIntValue,
            SettingStringValue
        )
        SELECT 101421,
               0,
               102, 
               100, 
               NULL;
    END;
    --Setting for 'BonusSystem - Adjust Max Bet for Bonus Abuse Protection'
    UPDATE tb_MGSDefaultModuleSetting
    SET SettingIntValue = 1,
        SettingStringValue = NULL
    WHERE ModuleID = 101421
          AND ClientID = 40300
          AND SettingID = 111;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO tb_MGSDefaultModuleSetting
        (
            ModuleID,
            ClientID,
            SettingID,
            SettingIntValue,
            SettingStringValue
        )
        SELECT 101421,
               40300,
               111, 
               1, 
               NULL;
    END;
    --Setting for 'Loyalty System - Wager Contribution Percentage'
    UPDATE tb_MGSDefaultModuleSetting
    SET SettingIntValue = 100,
        SettingStringValue = NULL
    WHERE ModuleID = 101421
          AND ClientID = 0
          AND SettingID = 158;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO tb_MGSDefaultModuleSetting
        (
            ModuleID,
            ClientID,
            SettingID,
            SettingIntValue,
            SettingStringValue
        )
        SELECT 101421,
               0,
               158, 
               100, 
               NULL;
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in  Region MSGDefaultSettings for ModuleID 101421 ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_MGSDefaultModuleSetting Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Install PGSI and MGS Default Setting Region
--------------------------------------------------------------------------------------------
BEGIN TRY
    --Now that the template values have been installed, apply the default template
    EXEC pr_ApplyTemplateValuesToPGSI 0, 101421, 40300, @ForceUpdate;
    --Apply the settings that do not belong to a Bet Model
    EXEC pr_ApplyMGSDefaultModuleSettings 101421, 40300, @ForceUpdate;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR:Error occured in Region PGSI and MGS Default Setting for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End PGSI and MGS Default Setting Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Default Module Setting Information Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Install tb_ThermometerInfo Setting  Region
--------------------------------------------------------------------------------------------
BEGIN TRY
    UPDATE tb_ThermometerInfo
    SET HeatConstant = 8000,
        BetMultiplier = 20,
        HotPercentage = 0
    WHERE ModuleID = 101421
          AND ClientID = 40300;
    IF @@ROWCOUNT = 0
    BEGIN 
        INSERT tb_ThermometerInfo
        (
            ModuleID,
            ClientID, 
            HeatConstant,
            BetMultiplier,
            HotPercentage
        )
        VALUES
        (101421, 40300, 8000, 20,0);
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in Region Thermometer Setting for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--End tb_ThermometerInfo Setting  Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Module Exclusion Information  Region
--------------------------------------------------------------------------------------------
BEGIN TRY
    IF EXISTS (SELECT ModuleID FROM tb_ExcludeModule WHERE ModuleID = 101421)
    BEGIN
       DELETE FROM tb_ExcludeModule 
       WHERE ModuleID = 101421;
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in Region Exclude Module for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--END Module Exclusion Information  Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Free Game Support Information Region
--------------------------------------------------------------------------------------------
BEGIN TRY
    UPDATE tb_FreeGameSupportedClient
    SET IsSupported = 1,
        IsBetSettingValidated = 0
    WHERE ModuleID = 101421
          AND ClientID = 40300;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT tb_FreeGameSupportedClient
        (
            ModuleID,
            ClientID,
            IsSupported,
            IsBetSettingValidated
        )
        VALUES
        (101421, 40300, 1, 0);
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in Region Free Game Support Client for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--Free Game Support Information End Region
--------------------------------------------------------------------------------------------
DECLARE @ChipSizes varchar(MAX)
set @ChipSizes = '1,2,5,10,20,25,50,100,200,500,1000,2000,2500,5000,10000'
IF @IsLvcsEnabled = 1
BEGIN
	set @ChipSizes = '1,2,5,10,20,25,50,100,200,500,1000,2000,2500,5000,10000,20000,50000,100000,200000,500000,1000000,2000000,5000000,10000000,20000000,50000000'
END

--------------------------------------------------------------------------------------------
--Valid Bet Limit Information Region
--------------------------------------------------------------------------------------------
BEGIN TRY
    UPDATE tb_Slot_ValidBetLimits
    SET Coins = 10,
        Paylines = 20,
        ChipSizes = @ChipSizes,
        SideBet = 0,
        SideBetToNumberLines = 0,
        SideBetToChipsize = 0,
        SideBetToNrcoins = 0,
        BetMultiplier = 0
    WHERE ModuleID = 101421;
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT tb_Slot_ValidBetLimits
        (
            ModuleID,
            Coins,
            Paylines,
            ChipSizes,
            SideBet,
            SideBetToNumberLines,
            SideBetToChipsize,
            SideBetToNrcoins,
            BetMultiplier
        )
        VALUES
        (101421, 10, 20, @ChipSizes, 0, 0, 0, 0, 0);
    END;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR: Error in  Region Slot Valid Bet Limits for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--Valid Bet Limit Information End Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Extended Slot Module  Region
--------------------------------------------------------------------------------------------
BEGIN TRY
    PRINT N'Installing Game Extra Game Bet Settings !'
    INSERT Casino.tb_ExtendedSlotModuleSetting
    SELECT newData.ModuleId, newData.SettingId
                FROM(

                SELECT 101421 AS ModuleId, 953 AS SettingId
                   ) newData
    LEFT JOIN Casino.tb_ExtendedSlotModuleSetting oldData
    ON newData.ModuleId = oldData.ModuleId
    AND newData.SettingId = oldData.SettingId
    WHERE oldData.ModuleId IS NULL;
END TRY
BEGIN CATCH
    SET @Msg = ERROR_MESSAGE();
    IF (XACT_STATE()) <> 0
    BEGIN
        PRINT N'The transaction is in an uncommittable state. Rolling back transaction.';
        ROLLBACK TRANSACTION;
    END;
    RAISERROR(N'ERROR:Error in Region Extended Bet Setting for ModuleID 101421 and ClientID 40300', 15, 1);
    RAISERROR(@Msg, 15, 1);
    RETURN;
END CATCH;
--------------------------------------------------------------------------------------------
--Extended Slot Module End  Region
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Validate the Game Installation Region
--------------------------------------------------------------------------------------------
BEGIN
    DECLARE @installationResult INT;
    EXEC @installationResult = pr_ValidateGameInstall 101421, 40300;
    IF (@installationResult <> 0)
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR(N'ERROR: Game Installation failed!', 15, 1);
        RETURN;
    END;
END;
--------------------------------------------------------------------------------------------
--End Validate the Game Installation Region
--------------------------------------------------------------------------------------------
COMMIT TRANSACTION;
PRINT N'Game Validation completed successfully!';
SET NOCOUNT OFF;
--------------------------------------------------------------------------------------------
        --Transaction Committed
--------------------------------------------------------------------------------------------
