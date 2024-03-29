USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_SelectAll]    Script Date: 12/21/2023 11:42:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Blogs_SelectAll]    Script Date: 12/12/2023 11:34:17 PM ******/
-- =============================================
-- Author: Angelia Beckstrom
-- Create date: 12/12/23
-- Description: Blogs Select All
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[Blogs_SelectAll]
			@PageIndex int
			,@PageSize int

as
/*-------------Test--------------

DECLARE @PageIndex int = 0
DECLARE @PageSize int = 5

Execute [dbo].[Blogs_SelectAll]
		@PageIndex
		,@PageSize

--------------------------------*/

BEGIN

DECLARE @offset int = @PageIndex * @PageSize


SELECT b.[Id] --primary key--
	  ,bt.[Id] --point of inner join -- b.BlogCategoryId --
	  ,bt.[Name] as Category
      ,Author = dbo.fn_GetUserJSON (b.AuthorId)
      ,b.[Title]
      ,b.[Subject]
      ,b.[Content]
      ,b.[IsPublished]
      ,b.[ImageUrl]
      ,b.[DateCreated]
      ,b.[DateModified]
      ,b.[DatePublish]
      ,b.[IsDeleted]
	  ,TotalCount = COUNT(1) OVER()

  FROM [dbo].[Blogs] as b inner join [dbo].[BlogTypes] as bt on b.BlogCategoryId = bt.Id

  Order BY b.Id

  OFFSET @offset Rows
  Fetch Next @PageSize Rows ONLY




END
GO
