USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_UpdateIsDeleted]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================
-- Author: Angelia Beckstrom
-- Create date: 12/20/23
-- Description: Blogs Soft Delete, updates IsDeleted column by Id
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[Blogs_UpdateIsDeleted]
			@Id int
			,@isDeleted bit

AS

/*----------------------------test------------

Declare @_Id int = 1
		,@isDeleted bit = 1

EXECUTE dbo.Blogs_UpdateIsDeleted
		@_Id
		,@_isDeleted

---------------------------------------------*/

BEGIN

DECLARE @dateModified DATETIME2(7) = GETUTCDATE()

UPDATE [dbo].[Blogs]
	
	SET [isDeleted] = @isDeleted
		,[DateModified] = @DateModified

	WHERE Id = @Id

END
GO
