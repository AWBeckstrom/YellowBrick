USE [YellowBrick]
GO
/****** Object:  Table [dbo].[BlogTypes]    Script Date: 9/27/2023 2:31:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_dbo.Blogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BlogTypes_SelectAll]    Script Date: 9/27/2023 2:31:40 PM ******/
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


GO
