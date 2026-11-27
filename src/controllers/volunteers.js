import { addVolunteer, removeVolunteer } from '../models/volunteers.js';

const processVolunteer = async (req, res) => {
    const projectId = parseInt(req.params.projectId, 10);

    if (Number.isNaN(projectId)) {
        req.flash('error', 'Invalid project.');
        return res.redirect('/projects');
    }

    try {
        await addVolunteer(req.session.user.user_id, projectId);
        req.flash('success', 'You are now volunteering for this project.');
        res.redirect(`/project/${projectId}`);
    } catch (error) {
        console.error('Error adding volunteer:', error);
        req.flash('error', 'Could not sign you up for that project.');
        res.redirect('/projects');
    }
};

const processUnvolunteer = async (req, res) => {
    const projectId = parseInt(req.params.projectId, 10);

    if (Number.isNaN(projectId)) {
        req.flash('error', 'Invalid project.');
        return res.redirect('/dashboard');
    }

    try {
        await removeVolunteer(req.session.user.user_id, projectId);
        req.flash('success', 'You are no longer volunteering for that project.');
    } catch (error) {
        console.error('Error removing volunteer:', error);
        req.flash('error', 'Could not remove you from that project.');
    }

    // The remove button exists on the dashboard and on the project page
    if (req.body.from === 'dashboard') {
        return res.redirect('/dashboard');
    }
    res.redirect(`/project/${projectId}`);
};

export { processVolunteer, processUnvolunteer };