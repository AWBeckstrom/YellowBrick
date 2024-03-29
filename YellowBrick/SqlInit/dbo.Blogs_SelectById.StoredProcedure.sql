USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_SelectById]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================
-- Author: Angelia Beckstrom
-- Create date: 12/20/23
-- Description: Blogs Select By Id
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[Blogs_SelectById]
			@Id int

AS

/*---------------------------

Declare @_Id int = 1
		
EXECUTE dbo.Blogs_SelectById
		@_Id
		
-----------------------------*/

BEGIN

  SELECT b.[Id] --primary key--
		  ,bt.[Id] --point of inner join -- b.BlogCategoryId --
		  ,bt.[Name] as Category
		  ,Author = dbo.fn_GetUserJSON (b.AuthorId)
      ,b.[Title]
      ,b.[Subject]
      ,b.[Content]
      ,b.[IsPublished]
      ,b.[ImageUrl] as BlogImage
      ,b.[DateCreated]
      ,b.[DateModified]
      ,b.[DatePublish]
      ,b.[IsDeleted]
	  
  FROM [dbo].[Blogs] AS b 
  INNER JOIN [dbo].[Users] as u on b.AuthorId = u.Id
  INNER JOIN [dbo].[BlogTypes] as bt on b.BlogCategoryId = bt.Id

  WHERE u.Id = @Id
 
 END
GO
