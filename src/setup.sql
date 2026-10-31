-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- Service Project Table
-- ========================================
CREATE TABLE service_project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    project_date DATE NOT NULL
);

-- ========================================
-- Insert sample data: Service Projects
-- ========================================
INSERT INTO service_project (organization_id, title, description, location, project_date)
VALUES
-- BrightFuture Builders (organization_id = 1)
(1, 'Community Playground Build', 'Construct a safe, accessible playground for a local elementary school.', 'Rexburg, ID', '2026-03-14'),
(1, 'Senior Center Roof Repair', 'Repair and reinforce the roof of a community senior center damaged by winter storms.', 'Idaho Falls, ID', '2026-04-02'),
(1, 'Accessible Ramp Installation', 'Build wheelchair-accessible ramps for low-income homeowners.', 'Rexburg, ID', '2026-05-10'),
(1, 'Youth Center Renovation', 'Renovate an aging youth center to provide a safe after-school space.', 'Pocatello, ID', '2026-06-21'),
(1, 'Community Garden Fencing', 'Install fencing around a new community garden to protect crops.', 'Rexburg, ID', '2026-07-09'),

-- GreenHarvest Growers (organization_id = 2)
(2, 'Urban Farm Planting Day', 'Volunteers plant seasonal vegetables at the urban farm plot.', 'Boise, ID', '2026-03-21'),
(2, 'Composting Workshop', 'Teach local residents how to compost food waste for garden use.', 'Boise, ID', '2026-04-18'),
(2, 'School Garden Build', 'Build a small teaching garden at a local elementary school.', 'Meridian, ID', '2026-05-15'),
(2, 'Farmers Market Education Booth', 'Set up an educational booth at the farmers market about sustainable growing.', 'Boise, ID', '2026-06-06'),
(2, 'Harvest Festival Volunteer Day', 'Help organize and run the annual harvest festival and food drive.', 'Nampa, ID', '2026-09-26'),

-- UnityServe Volunteers (organization_id = 3)
(3, 'Food Bank Sorting Day', 'Sort and package donated food items for local food bank distribution.', 'Idaho Falls, ID', '2026-03-07'),
(3, 'Winter Coat Drive', 'Collect and distribute winter coats to families in need.', 'Idaho Falls, ID', '2026-11-14'),
(3, 'Homeless Shelter Meal Service', 'Prepare and serve meals at a local homeless shelter.', 'Idaho Falls, ID', '2026-04-25'),
(3, 'Volunteer Appreciation Cleanup', 'Organize a neighborhood cleanup event with local volunteers.', 'Rigby, ID', '2026-05-30'),
(3, 'Holiday Gift Drive', 'Collect and wrap gifts for underprivileged children during the holiday season.', 'Idaho Falls, ID', '2026-12-05');

-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- ========================================
-- Insert sample data: Categories
-- ========================================
INSERT INTO category (name)
VALUES
('Construction'),
('Education'),
('Food Security'),
('Environment'),
('Community Outreach');

-- ========================================
-- Project_Category Junction Table (Many-to-Many)
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES service_project(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);

-- ========================================
-- Insert sample data: Project_Category associations
-- ========================================
INSERT INTO project_category (project_id, category_id)
VALUES
(1, 1),  -- Community Playground Build -> Construction
(2, 1),  -- Senior Center Roof Repair -> Construction
(3, 1),  -- Accessible Ramp Installation -> Construction
(4, 1),  -- Youth Center Renovation -> Construction
(4, 5),  -- Youth Center Renovation -> Community Outreach
(5, 4),  -- Community Garden Fencing -> Environment
(6, 4),  -- Urban Farm Planting Day -> Environment
(6, 3),  -- Urban Farm Planting Day -> Food Security
(7, 2),  -- Composting Workshop -> Education
(7, 4),  -- Composting Workshop -> Environment
(8, 2),  -- School Garden Build -> Education
(8, 4),  -- School Garden Build -> Environment
(9, 2),  -- Farmers Market Education Booth -> Education
(9, 3),  -- Farmers Market Education Booth -> Food Security
(10, 3), -- Harvest Festival Volunteer Day -> Food Security
(10, 5), -- Harvest Festival Volunteer Day -> Community Outreach
(11, 3), -- Food Bank Sorting Day -> Food Security
(12, 5), -- Winter Coat Drive -> Community Outreach
(13, 3), -- Homeless Shelter Meal Service -> Food Security
(14, 5), -- Volunteer Appreciation Cleanup -> Community Outreach
(14, 4), -- Volunteer Appreciation Cleanup -> Environment
(15, 5); -- Holiday Gift Drive -> Community Outreach