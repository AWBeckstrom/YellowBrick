USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[BlogTypes_SelectAll]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Angelia Beckstrom
-- Create date: 9/26/23
-- Description: Blog Types Select All Procedure
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2023
-- Code Reviewer:
-- Note:
-- =============================================


CREATE proc [dbo].[BlogTypes_SelectAll]
as

/*

-------------Test--------------


*/

BEGIN

SELECT [Id]
      ,[Name]
  FROM [dbo].[BlogTypes]

END



