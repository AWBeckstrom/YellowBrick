USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_Update]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================
-- Author: Angelia Beckstrom
-- Create date: 12/20/23
-- Description: Blogs Update
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE Proc [dbo].[Blogs_Update]
			@BlogCategoryId int
			  ,@AuthorId int
			  ,@Title nvarchar(100)
			  ,@Subject nvarchar(50)
			  ,@Content nvarchar(4000) = null
			  ,@IsPublished bit
			  ,@ImageUrl nvarchar(255) = null
			  ,@DatePublish datetime2(7) = null
			  ,@IsDeleted bit
			  ,@Id int

AS

/*------------------------------------test code--------

DECLARE	  @Id int

DECLARE		@_BlogCategoryId int = '1'
			  ,@_AuthorId int = '2'
			  ,@_Title nvarchar(100) = 'Rates and Emotions'
			  ,@_Subject nvarchar(50) = 'Rates'
			  ,@_Content nvarchar(4000) = 'The emotions behind whether rates are too high to begin a loan are relative'
			  ,@_IsPublished bit = 'true'
			  ,@_ImageUrl nvarchar(255) = 'https://i.imgur.com/2BlM3Jc.jpg'
			  ,@_DatePublish datetime2(7) = 2023-10-15
			  ,@_IsDeleted bit = 'true'
			  
EXECUTE
			@_BlogCategoryId
			  ,@_AuthorId
			  ,@_Title
			  ,@_Subject
			  ,@_Content
			  ,@_IsPublished
			  ,@_ImageUrl
			  ,@_DatePublish
			  ,@_IsDeleted
			  ,@_Id
------------------------------------------------------*/
BEGIN

DECLARE	@DateModified datetime2(7) = getutcdate()

UPDATE [dbo].[Blogs]

   SET [BlogCategoryId] = @BlogCategoryId
      ,[AuthorId] = @AuthorId
      ,[Title] = @Title
      ,[Subject] = @Subject
      ,[Content] = @Content
      ,[IsPublished] = @IsPublished
      ,[ImageUrl] = @ImageUrl
      ,[DateModified] = @DateModified
      ,[DatePublish] = @DatePublish
      ,[IsDeleted] = @IsDeleted

WHERE Id = @Id

END


GO
