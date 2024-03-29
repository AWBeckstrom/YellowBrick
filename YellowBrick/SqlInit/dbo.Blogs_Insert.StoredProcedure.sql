USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_Insert]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Angelia Beckstrom
-- Create date: 12/12/23
-- Description: Blogs Insert
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[Blogs_Insert]
           @BlogCategoryId int
           ,@AuthorId int
           ,@Title nvarchar(100)
           ,@Subject nvarchar(50)
           ,@Content nvarchar(4000)
           ,@IsPublished bit
           ,@ImageUrl nvarchar(255)
           ,@DateCreated datetime2(7)
           ,@DateModified datetime2(7)
           ,@DatePublish datetime2(7)
           ,@IsDeleted bit
		   ,@Id int OUTPUT

AS
/*-----------------------------------------test-
		   
DECLARE		@Id int = 0

DECLARE		BlogCategoryId int = 1 
           ,AuthorId int = 1
           ,Title nvarchar(100) = 'Understanding Rates' 
           ,Subject nvarchar(50) = 'Loans'
           ,Content nvarchar(4000) = 'Interest rates make taking out a loan feel risky'
           ,IsPublished bit = 0
           ,ImageUrl nvarchar(255) = 'https://imgur.com/yGUqgGc'
           ,DateCreated datetime2(7) = '2023-12-13'
           ,DateModified datetime2(7) = '2023-12-13'
           ,DatePublish datetime2(7) =  'null'
           ,IsDeleted bit = 0

Execute [dbo].[Blogs_Insert]
		   @BlogCategoryId
           ,@AuthorId
           ,@Title
           ,@Subject
           ,@Content
           ,@IsPublished
           ,@ImageUrl
           ,@DatePublish
           ,@IsDeleted
		   ,@Id OUTPUT

Select * 
From dbo.blogs
Where Id = @Id
--------------------------------------------------------*/
BEGIN

INSERT INTO [dbo].[Blogs]
           ([BlogCategoryId]
           ,[AuthorId]
           ,[Title]
           ,[Subject]
           ,[Content]
           ,[IsPublished]
           ,[ImageUrl]
           ,[DateCreated]
           ,[DateModified]
           ,[DatePublish]
           ,[IsDeleted])
     
	 VALUES
           (@BlogCategoryId 
           ,@AuthorId 
           ,@Title 
           ,@Subject 
           ,@Content 
           ,@IsPublished 
           ,@ImageUrl 
           ,@DateCreated 
           ,@DateModified 
           ,@DatePublish 
           ,@IsDeleted )

SET @Id =  SCOPE_IDENTITY()

END
GO
