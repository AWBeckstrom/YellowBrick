USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_SelectByCreatedBy]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Angelia Beckstrom
-- Create date: 12/19/23
-- Description: Blogs Select ByCreatedBy
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE Proc [dbo].[Blogs_SelectByCreatedBy]
			@Id int
			,@PageIndex int
			,@PageSize int

AS
/*----------------------------
Declare @_Id int = 1
		,@_PageIndex int = 0
		,@_PageSize int = 8

EXECUTE dbo.Blogs_SelectByCreatedBy
		@_Id
		,@_PageIndex
		,@_PageSize

-----------------------*/

BEGIN

Declare @offset int = @PageIndex * @PageSize

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
	  ,TotalCount = COUNT(1) OVER()

  FROM [dbo].[Blogs] as b 
  INNER JOIN [dbo].[Users] as u on b.AuthorId = u.Id
  INNER JOIN [dbo].[BlogTypes] as bt on b.BlogCategoryId = bt.Id

  WHERE u.Id = @Id
  Order BY u.Id

  OFFSET @offset Rows
  Fetch Next @PageSize Rows ONLY

END


GO
